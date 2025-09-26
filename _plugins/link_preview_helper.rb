module Jekyll
  module LinkPreviewHelper
    def load_link_preview(url)
      return nil unless url
      
      safe_filename = url.gsub(/[^a-zA-Z0-9\-_]/, '_')[0..50]
      preview_file = File.join(@site.source, 'link_previews', "#{safe_filename}.json")
      
      if File.exist?(preview_file)
        JSON.parse(File.read(preview_file))
      else
        nil
      end
    rescue => e
      Jekyll.logger.warn "Failed to load link preview for #{url}: #{e.message}"
      nil
    end

    def extract_urls_from_text(text)
      return [] unless text
      text.scan(/https?:\/\/[^\s\)]+/)
    end

    def render_link_preview(url, title = nil)
      preview = load_link_preview(url)
      return render_fallback_link(url, title) unless preview
      
      safe_filename = url.gsub(/[^a-zA-Z0-9\-_]/, '_')[0..50]
      image_path = "link_previews/#{safe_filename}.jpg"
      
      <<~HTML
        <div class="link-preview" onclick="window.open('#{url}', '_blank')" 
             style="max-width: 300px; height: 200px; background: var(--container-bg); border: 2px solid var(--border-color); border-radius: 8px; cursor: pointer; overflow: hidden; transition: all 0.2s ease; margin: 10px 0;"
             onmouseover="this.style.borderColor='#007bff'; this.style.transform='scale(1.02)'"
             onmouseout="this.style.borderColor='var(--border-color)'; this.style.transform='scale(1)'">
          #{preview['image'] ? "<img src=\"#{image_path}\" alt=\"#{preview['title'] || 'Link Preview'}\" style=\"width: 100%; height: 120px; object-fit: cover;\">" : ""}
          <div style="padding: 12px;">
            <h5 style="margin: 0 0 8px 0; color: var(--heading-color); font-size: 14px; line-height: 1.3; overflow: hidden; text-overflow: ellipsis; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical;">#{preview['title'] || title || 'Link'}</h5>
            <p style="margin: 0; color: var(--subheading-color); font-size: 12px; line-height: 1.3; overflow: hidden; text-overflow: ellipsis; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical;">#{preview['description'] || ''}</p>
            <div style="margin-top: 8px; font-size: 10px; color: var(--link-color); text-transform: uppercase; letter-spacing: 0.5px;">#{URI.parse(url).host}</div>
          </div>
        </div>
      HTML
    end

    def render_fallback_link(url, title = nil)
      domain = URI.parse(url).host rescue url
      <<~HTML
        <div class="link-preview-fallback" onclick="window.open('#{url}', '_blank')" 
             style="max-width: 300px; height: 80px; background: var(--container-bg); border: 2px solid var(--border-color); border-radius: 8px; cursor: pointer; display: flex; align-items: center; padding: 12px; transition: all 0.2s ease; margin: 10px 0;"
             onmouseover="this.style.borderColor='#007bff'; this.style.transform='scale(1.02)'"
             onmouseout="this.style.borderColor='var(--border-color)'; this.style.transform='scale(1)'">
          <div style="flex: 1;">
            <h5 style="margin: 0 0 4px 0; color: var(--heading-color); font-size: 14px;">#{title || 'External Link'}</h5>
            <div style="font-size: 12px; color: var(--link-color); text-transform: uppercase; letter-spacing: 0.5px;">#{domain}</div>
          </div>
          <div style="font-size: 20px; color: var(--link-color); margin-left: 12px;">↗</div>
        </div>
      HTML
    end
  end
end

Liquid::Template.register_filter(Jekyll::LinkPreviewHelper)
