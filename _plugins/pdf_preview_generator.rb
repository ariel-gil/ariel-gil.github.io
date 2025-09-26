require 'fileutils'
require 'mini_magick'

module Jekyll
  class PdfPreviewGenerator < Generator
    safe true
    priority :low

    def generate(site)
      return unless site.config['pdf_previews'] != false
      
      # Create previews directory
      previews_dir = File.join(site.source, 'pdf_previews')
      FileUtils.mkdir_p(previews_dir) unless Dir.exist?(previews_dir)
      
      # Find all PDF files in the site
      pdf_files = Dir.glob(File.join(site.source, '**', '*.pdf'))
      
      pdf_files.each do |pdf_path|
        relative_pdf_path = Pathname.new(pdf_path).relative_path_from(Pathname.new(site.source)).to_s
        preview_path = File.join(site.source, 'pdf_previews', File.basename(pdf_path, '.pdf') + '_preview.jpg')
        relative_preview_path = File.join('pdf_previews', File.basename(pdf_path, '.pdf') + '_preview.jpg')
        
        # Skip if preview already exists and is newer than PDF
        if File.exist?(preview_path) && File.mtime(preview_path) > File.mtime(pdf_path)
          next
        end
        
        begin
          # Generate preview using MiniMagick
          image = MiniMagick::Image.open(pdf_path)
          image.format 'jpg'
          image.resize '300x400>'  # Resize to fit within 300x400, maintaining aspect ratio
          image.quality 85
          image.write(preview_path)
          
          # Add to site static files
          static_file = Jekyll::StaticFile.new(site, site.source, 'pdf_previews', File.basename(preview_path))
          site.static_files << static_file
          
          Jekyll.logger.info "Generated PDF preview: #{relative_preview_path}"
        rescue => e
          Jekyll.logger.warn "Failed to generate preview for #{relative_pdf_path}: #{e.message}"
        end
      end
    end
  end
end
