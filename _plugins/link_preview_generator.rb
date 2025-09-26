require 'net/http'
require 'uri'
require 'json'
require 'fileutils'
require 'mini_magick'

module Jekyll
  class LinkPreviewGenerator < Generator
    safe true
    priority :low

    def generate(site)
      return unless site.config['link_previews'] != false
      
      # Create previews directory
      previews_dir = File.join(site.source, 'link_previews')
      FileUtils.mkdir_p(previews_dir) unless Dir.exist?(previews_dir)
      
      # Find all URLs in data files
      urls = extract_urls_from_data(site)
      
      urls.each do |url_data|
        generate_preview_for_url(site, url_data, previews_dir)
      end
    end

    private

    def extract_urls_from_data(site)
      urls = []
      
      # Extract URLs from all data files
      Dir.glob(File.join(site.source, '_data', '*.yml')).each do |file|
        data = YAML.load_file(file)
        urls.concat(extract_urls_from_yaml(data, file))
      end
      
      urls
    end

    def extract_urls_from_yaml(data, file_path)
      urls = []
      
      if data.is_a?(Array)
        data.each_with_index do |item, index|
          if item.is_a?(Hash)
            item.each do |key, value|
              if value.is_a?(String) && value.match?(/https?:\/\/[^\s]+/)
                # Extract URLs from description text
                url_matches = value.scan(/https?:\/\/[^\s\)]+/)
                url_matches.each do |url|
                  urls << {
                    url: url,
                    source_file: file_path,
                    source_key: key,
                    source_index: index
                  }
                end
              elsif key == 'url' && value.is_a?(String) && value.match?(/https?:\/\/[^\s]+/)
                urls << {
                  url: value,
                  source_file: file_path,
                  source_key: key,
                  source_index: index
                }
              end
            end
          end
        end
      end
      
      urls
    end

    def generate_preview_for_url(site, url_data, previews_dir)
      url = url_data[:url]
      safe_filename = url.gsub(/[^a-zA-Z0-9\-_]/, '_')[0..50]
      preview_file = File.join(previews_dir, "#{safe_filename}.json")
      image_file = File.join(previews_dir, "#{safe_filename}.jpg")
      
      # Skip if preview already exists and is recent (less than 7 days old)
      if File.exist?(preview_file) && File.mtime(preview_file) > (Time.now - 7 * 24 * 60 * 60)
        return
      end
      
      begin
        # Fetch Open Graph metadata
        metadata = fetch_metadata(url)
        
        if metadata && !metadata.empty?
          # Save metadata
          File.write(preview_file, JSON.pretty_generate(metadata))
          
          # Generate preview image if we have an image URL
          if metadata['image'] && !metadata['image'].empty?
            generate_preview_image(metadata['image'], image_file)
          end
          
          # Add to site static files
          if File.exist?(preview_file)
            static_file = Jekyll::StaticFile.new(site, site.source, 'link_previews', File.basename(preview_file))
            site.static_files << static_file
          end
          
          if File.exist?(image_file)
            static_file = Jekyll::StaticFile.new(site, site.source, 'link_previews', File.basename(image_file))
            site.static_files << static_file
          end
          
          Jekyll.logger.info "Generated link preview for: #{url}"
        end
      rescue => e
        Jekyll.logger.warn "Failed to generate preview for #{url}: #{e.message}"
      end
    end

    def fetch_metadata(url)
      uri = URI(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if uri.scheme == 'https'
      http.read_timeout = 10
      http.open_timeout = 10
      
      request = Net::HTTP::Get.new(uri)
      request['User-Agent'] = 'Mozilla/5.0 (compatible; Jekyll Link Preview Generator)'
      
      response = http.request(request)
      
      if response.code == '200'
        html = response.body
        extract_open_graph_metadata(html, url)
      else
        nil
      end
    rescue => e
      Jekyll.logger.warn "Failed to fetch #{url}: #{e.message}"
      nil
    end

    def extract_open_graph_metadata(html, base_url)
      metadata = {}
      
      # Extract Open Graph tags
      og_patterns = {
        'title' => /<meta[^>]*property=["']og:title["'][^>]*content=["']([^"']*)["']/i,
        'description' => /<meta[^>]*property=["']og:description["'][^>]*content=["']([^"']*)["']/i,
        'image' => /<meta[^>]*property=["']og:image["'][^>]*content=["']([^"']*)["']/i,
        'url' => /<meta[^>]*property=["']og:url["'][^>]*content=["']([^"']*)["']/i,
        'site_name' => /<meta[^>]*property=["']og:site_name["'][^>]*content=["']([^"']*)["']/i
      }
      
      # Fallback to regular meta tags
      fallback_patterns = {
        'title' => /<title[^>]*>([^<]*)<\/title>/i,
        'description' => /<meta[^>]*name=["']description["'][^>]*content=["']([^"']*)["']/i
      }
      
      # Try Open Graph first
      og_patterns.each do |key, pattern|
        match = html.match(pattern)
        if match && !match[1].empty?
          metadata[key] = clean_text(match[1])
        end
      end
      
      # Fallback to regular meta tags if Open Graph not available
      fallback_patterns.each do |key, pattern|
        if metadata[key].nil? || metadata[key].empty?
          match = html.match(pattern)
          if match && !match[1].empty?
            metadata[key] = clean_text(match[1])
          end
        end
      end
      
      # Clean up image URL
      if metadata['image']
        metadata['image'] = resolve_relative_url(metadata['image'], base_url)
      end
      
      # Add original URL
      metadata['original_url'] = base_url
      
      metadata
    end

    def clean_text(text)
      text.gsub(/\s+/, ' ').strip
    end

    def resolve_relative_url(url, base_url)
      return url if url.start_with?('http')
      
      base_uri = URI(base_url)
      if url.start_with?('//')
        "#{base_uri.scheme}:#{url}"
      elsif url.start_with?('/')
        "#{base_uri.scheme}://#{base_uri.host}#{url}"
      else
        "#{base_uri.scheme}://#{base_uri.host}/#{url}"
      end
    end

    def generate_preview_image(image_url, output_path)
      return unless image_url && !image_url.empty?
      
      begin
        # Download and process image
        image = MiniMagick::Image.open(image_url)
        image.format 'jpg'
        image.resize '300x200>'  # Resize to fit within 300x200, maintaining aspect ratio
        image.quality 85
        image.write(output_path)
        
        Jekyll.logger.info "Generated preview image: #{output_path}"
      rescue => e
        Jekyll.logger.warn "Failed to generate preview image for #{image_url}: #{e.message}"
      end
    end
  end
end
