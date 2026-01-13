# Claude Code Instructions for ariel-gil.github.io

## Project Overview
Personal portfolio website for Ariel Gil - Jekyll-based static site hosted on GitHub Pages.

## Tech Stack
- Jekyll static site generator
- GitHub Pages hosting
- Custom plugins: link_preview_generator, pdf_preview_generator

## Project Structure
```
_layouts/default.html    # Main layout template (header, nav, profile info)
index.md                 # Homepage content
misc.md                  # Misc page
tools.md                 # Tools page
_config.yml              # Jekyll configuration
_data/                   # YAML data files for dynamic content
  - ai_safety_projects.yml
  - coding_projects.yml
  - other_projects.yml
  - publications.yml
  - misc_sections.yml
```

## Key Locations
- **Profile info** (name, position, social links): `_layouts/default.html` lines 374-397
- **Site metadata** (title, description): `_config.yml`
- **Homepage content**: `index.md`
- **Projects data**: `_data/*.yml` files

## Common Tasks
- Update position/title: Edit `_layouts/default.html` (header-text section, ~line 377)
- Update About text: Edit `index.md` (about section)
- Add publication: Add entry to `_data/publications.yml`
- Add project: Add entry to relevant `_data/*_projects.yml` file

## Build & Preview
```bash
bundle exec jekyll serve
```
Site will be available at http://localhost:4000
