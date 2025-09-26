# PDF Preview Setup

This Jekyll site now supports automatic PDF preview generation. Here's how to set it up:

## Prerequisites

1. **Install ImageMagick**: Download and install ImageMagick from https://imagemagick.org/script/download.php
2. **Install Ruby gems**: Run `bundle install` to install the required dependencies including `mini_magick`

## How it works

1. **Plugin**: The `_plugins/pdf_preview_generator.rb` plugin automatically scans for PDF files in your site
2. **Preview Generation**: For each PDF found, it generates a preview image (300x400px max, maintaining aspect ratio)
3. **Template Integration**: The `index.md` template automatically displays preview images for PDFs, with fallback to emoji placeholder if preview doesn't exist

## File Structure

- PDFs are stored in your `images/` directories
- Preview images are generated in `pdf_previews/` directory
- Preview images follow the naming pattern: `{pdf_filename}_preview.jpg`

## Current PDF Files

- `images/offroad/original_pdf_905927_tx5qprabuqtsvm_vekug8uvpx.pdf`
  - Preview will be: `pdf_previews/original_pdf_905927_tx5qprabuqtsvm_vekug8uvpx_preview.jpg`

## Testing

To test the functionality:

1. Install ImageMagick
2. Run `bundle install`
3. Run `bundle exec jekyll serve` or `bundle exec jekyll build`
4. Check that preview images are generated in the `pdf_previews/` directory
5. View your site to see PDF previews instead of emoji placeholders

## Fallback Behavior

If a preview image fails to generate or doesn't exist, the site will automatically fall back to showing the emoji placeholder (📄 PDF) with the same click functionality.
