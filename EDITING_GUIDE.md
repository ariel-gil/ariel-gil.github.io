# Quick Editing Guide

This guide lists where to find and update common content on the site.

## Position/Role Changes

### Header Position Title
**File:** `_layouts/default.html`  
**Line:** 375-376  
**What to change:**
- Line 375: Main title (e.g., "AI Safety Researcher & Mechatronics Engineer")
- Line 376: Current position/role (e.g., "Advisor / Board President at AI Standards Lab")

### About Section
**File:** `index.md`  
**Lines:** 7-14  
**What to change:**
- Update your current work description
- Update position mentions (e.g., "advisory/board role")

## Site-Wide Descriptions

### Main Site Title & Description
**File:** `_config.yml`  
**Lines:** 1-2  
**What to change:**
- `title`: Site title (appears in browser tab)
- `description`: Default meta description for SEO

### Home Page Description
**File:** `index.md`  
**Lines:** 3-4  
**What to change:**
- `description`: Page-specific meta description

### Web Manifest (PWA)
**File:** `site.webmanifest`  
**Lines:** 2-4  
**What to change:**
- `name`: App name
- `description`: App description

## Contact Information

### Email Address
**File:** `index.md`  
**Line:** 291  
**What to change:**
- Update the email address in the contact section

## Social Links

### LinkedIn, Google Scholar, GitHub
**File:** `_layouts/default.html`  
**Lines:** 378-395  
**What to change:**
- Update URLs for social media profiles
- Update `aria-label` text if needed

## Profile Image

### Header Photo
**File:** `_layouts/default.html`  
**Line:** 372  
**What to change:**
- Update the image path (currently `IMG_2992.JPG`)
- Also update line 11 for Open Graph image (social media previews)

## Projects & Content

### Projects
**Files:** 
- `_data/ai_safety_projects.yml`
- `_data/projects.yml`
- `_data/coding_projects.yml`
- `_data/other_projects.yml`

### Publications
**File:** `_data/publications.yml`

### Misc Content
**File:** `_data/misc_sections.yml`

## Navigation

### Menu Links
**File:** `_layouts/default.html`  
**Lines:** 365-368  
**What to change:**
- Add/remove navigation links
- Update URLs

## Quick Checklist for Position Change

When your position changes, update:
1. ✅ `_layouts/default.html` line 375-376 (header)
2. ✅ `index.md` line 4 (page description)
3. ✅ `index.md` lines 7-14 (about section)
4. ✅ `_config.yml` line 1-2 (site title/description)
5. ✅ `site.webmanifest` line 2-4 (app name/description)

