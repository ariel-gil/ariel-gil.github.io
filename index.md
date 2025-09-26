---
layout: default
title: Home
description: AI Safety Researcher focusing on AI Risk management, standards and policy. Former medical robotics engineer.
---

<section id="about">
    <h3>About Me</h3>
    <p>I am a Technical AI Governance Researcher, having worked on the EU AI Act standards and Codes of Practice. In 2023, I co-founded the <a href="https://ai-standards-lab.org/" target="_blank">AI Standards Lab</a>, a 501(c)(3) supporting EU standards and the recent Codes of Practice. Currently, I am on a short sabbatical while staying as an Advisor/Board President.</p>
        
    <p>Originally a Mechatronics Engineer, I was the 4th member of a semi-autonomous ophthalmic surgical robotics startup that raised $50M and grew to 50+ employees. Later, I worked in ML-based ultrasound diagnostics and laser eye-floater treatment. My AI governance work is informed by my risk management experience, as well as technical and conceptual AI safety knowledge I've picked up along the way. Currently, I am exploring governance for shorter timelines, scalable oversight related experiments, as well as getting into direct technical work.</p>
    
    <p>In my free time, I mountain bike, rock climb, hike, and dance salsa (when not injured!). I also do occasional small design projects and 3D printing. You can see some of my previous engineering projects in <a href="https://www.coroflot.com/ArielGil" target="_blank">my design portfolio</a>.</p>
</section>

<section id="previous-ai-safety-projects">
    <h3>Previous AI Safety Projects</h3>
    
    <!-- Show first 2 projects by default -->
    {% for project in site.data.ai_safety_projects limit:2 %}
    <div class="project">
        <h4>{{ project.title }}</h4>
        {% if project.images %}
        <div class="image-gallery" style="display: flex; gap: 10px; margin: 10px 0; flex-wrap: wrap;">
            {% for img in project.images %}
            {% if img contains '.pdf' %}
            {% assign pdf_filename = img | split: '/' | last | split: '.' | first %}
            {% assign preview_path = 'pdf_previews/' | append: pdf_filename | append: '_preview.jpg' %}
            <img src="{{ preview_path }}" alt="{{ project.title }} PDF Preview" 
                 onclick="openPdf('{{ img }}', '{{ project.title }}')"
                 style="max-width: 150px; height: 100px; object-fit: cover; border-radius: 6px; cursor: pointer; border: 2px solid #e9ecef; transition: all 0.2s ease;"
                 onmouseover="this.style.borderColor='#007bff'; this.style.transform='scale(1.02)'"
                 onmouseout="this.style.borderColor='#e9ecef'; this.style.transform='scale(1)'"
                 onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
            <div onclick="openPdf('{{ img }}', '{{ project.title }}')"
                 style="max-width: 150px; height: 100px; background: #f8f9fa; border: 2px solid #e9ecef; border-radius: 6px; cursor: pointer; display: none; flex-direction: column; align-items: center; justify-content: center; transition: all 0.2s ease;"
                 onmouseover="this.style.borderColor='#007bff'; this.style.transform='scale(1.02)'"
                 onmouseout="this.style.borderColor='#e9ecef'; this.style.transform='scale(1)'">
                <div style="font-size: 24px; margin-bottom: 5px;">📄</div>
                <div style="font-size: 10px; text-align: center; color: #666;">PDF</div>
            </div>
            {% else %}
            <img src="{{ img }}" alt="{{ project.title }}" 
                 onclick="openImageModal('{{ img }}', '{{ project.title }}')"
                 style="max-width: 150px; height: 100px; object-fit: cover; border-radius: 6px; cursor: pointer; border: 2px solid #e9ecef; transition: all 0.2s ease;"
                 onmouseover="this.style.borderColor='#007bff'; this.style.transform='scale(1.02)'"
                 onmouseout="this.style.borderColor='#e9ecef'; this.style.transform='scale(1)'">
            {% endif %}
            {% endfor %}
        </div>
        {% elsif project.image %}
        <img src="{{ project.image }}" alt="{{ project.title }}" style="max-width: 300px; margin: 10px 0; border-radius: 8px;">
        {% endif %}
        <p>{{ project.description | markdownify }}</p>
    </div>
    {% endfor %}
    
    <div class="toggle-container">
        <button id="toggle-ai-safety-projects" onclick="toggleAiSafetyProjects()" class="toggle-button">
            <span id="toggle-ai-safety-text">View more projects</span>
            <span id="toggle-ai-safety-arrow">▼</span>
        </button>
    </div>
    
    <div id="ai-safety-projects-content" class="fade-content" style="display: none;">
        {% for project in site.data.ai_safety_projects offset:2 %}
        <div class="project">
            <h4>{{ project.title }}</h4>
            {% if project.images %}
            <div class="image-gallery" style="display: flex; gap: 10px; margin: 10px 0; flex-wrap: wrap;">
                {% for img in project.images %}
                {% if img contains '.pdf' %}
                {% assign pdf_filename = img | split: '/' | last | split: '.' | first %}
                {% assign preview_path = 'pdf_previews/' | append: pdf_filename | append: '_preview.jpg' %}
                <img src="{{ preview_path }}" alt="{{ project.title }} PDF Preview" 
                     onclick="openPdf('{{ img }}', '{{ project.title }}')"
                     style="max-width: 150px; height: 100px; object-fit: cover; border-radius: 6px; cursor: pointer; border: 2px solid #e9ecef; transition: all 0.2s ease;"
                     onmouseover="this.style.borderColor='#007bff'; this.style.transform='scale(1.02)'"
                     onmouseout="this.style.borderColor='#e9ecef'; this.style.transform='scale(1)'"
                     onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                <div onclick="openPdf('{{ img }}', '{{ project.title }}')"
                     style="max-width: 150px; height: 100px; background: #f8f9fa; border: 2px solid #e9ecef; border-radius: 6px; cursor: pointer; display: none; flex-direction: column; align-items: center; justify-content: center; transition: all 0.2s ease;"
                     onmouseover="this.style.borderColor='#007bff'; this.style.transform='scale(1.02)'"
                     onmouseout="this.style.borderColor='#e9ecef'; this.style.transform='scale(1)'">
                    <div style="font-size: 24px; margin-bottom: 5px;">📄</div>
                    <div style="font-size: 10px; text-align: center; color: #666;">PDF</div>
                </div>
                {% else %}
                <img src="{{ img }}" alt="{{ project.title }}" 
                     onclick="openImageModal('{{ img }}', '{{ project.title }}')"
                     style="max-width: 150px; height: 100px; object-fit: cover; border-radius: 6px; cursor: pointer; border: 2px solid #e9ecef; transition: all 0.2s ease;"
                     onmouseover="this.style.borderColor='#007bff'; this.style.transform='scale(1.02)'"
                     onmouseout="this.style.borderColor='#e9ecef'; this.style.transform='scale(1)'">
                {% endif %}
                {% endfor %}
            </div>
            {% elsif project.image %}
            <img src="{{ project.image }}" alt="{{ project.title }}" style="max-width: 300px; margin: 10px 0; border-radius: 8px;">
            {% endif %}
            <p>{{ project.description | markdownify }}</p>
        </div>
        {% endfor %}
    </div>
</section>

<section id="current-projects">
    <h3>Current Projects</h3>
    
    {% for project in site.data.projects %}
    <div class="project">
        <h4>{{ project.title }}</h4>
        <p>{{ project.description | markdownify }}</p>
    </div>
    {% endfor %}
</section>



<section id="publications">
    <h3>Selected Publications and working papers</h3>
    <ul class="publications">
        {% for pub in site.data.publications %}
        <li>
            <img src="https://www.google.com/s2/favicons?domain={{ pub.domain }}" alt="{{ pub.domain }} favicon" style="width:18px;height:18px;margin-right:0.5em;vertical-align:middle;">
            <div>
                <a href="{{ pub.url }}" target="_blank" class="pub-title">
                    {{ pub.title }}
                </a>
                {% if pub.meta %}
                <span class="pub-meta">{{ pub.meta }}</span>
                {% endif %}
            </div>
        </li>
        {% endfor %}
    </ul>
</section>

<section id="other-projects">
    <h3>Engineering Projects</h3>
    
    <!-- Show first project by default -->
    {% assign first_project = site.data.other_projects.first %}
     <div class="project">
         <h4>{{ first_project.title }}</h4>
         {% if first_project.images %}
         <div class="image-gallery" style="display: flex; gap: 10px; margin: 10px 0; flex-wrap: wrap;">
             {% for img in first_project.images %}
             {% if img contains '.pdf' %}
             {% assign pdf_filename = img | split: '/' | last | split: '.' | first %}
             {% assign preview_path = 'pdf_previews/' | append: pdf_filename | append: '_preview.jpg' %}
             <img src="{{ preview_path }}" alt="{{ first_project.title }} PDF Preview" 
                  onclick="openPdf('{{ img }}', '{{ first_project.title }}')"
                  style="max-width: 150px; height: 100px; object-fit: cover; border-radius: 6px; cursor: pointer; border: 2px solid #e9ecef; transition: all 0.2s ease;"
                  onmouseover="this.style.borderColor='#007bff'; this.style.transform='scale(1.02)'"
                  onmouseout="this.style.borderColor='#e9ecef'; this.style.transform='scale(1)'"
                  onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
             <div onclick="openPdf('{{ img }}', '{{ first_project.title }}')"
                  style="max-width: 150px; height: 100px; background: #f8f9fa; border: 2px solid #e9ecef; border-radius: 6px; cursor: pointer; display: none; flex-direction: column; align-items: center; justify-content: center; transition: all 0.2s ease;"
                  onmouseover="this.style.borderColor='#007bff'; this.style.transform='scale(1.02)'"
                  onmouseout="this.style.borderColor='#e9ecef'; this.style.transform='scale(1)'">
                 <div style="font-size: 24px; margin-bottom: 5px;">📄</div>
                 <div style="font-size: 10px; text-align: center; color: #666;">PDF</div>
             </div>
             {% else %}
             <img src="{{ img }}" alt="{{ first_project.title }}" 
                  onclick="openImageModal('{{ img }}', '{{ first_project.title }}')"
                  style="max-width: 150px; height: 100px; object-fit: cover; border-radius: 6px; cursor: pointer; border: 2px solid #e9ecef; transition: all 0.2s ease;"
                  onmouseover="this.style.borderColor='#007bff'; this.style.transform='scale(1.02)'"
                  onmouseout="this.style.borderColor='#e9ecef'; this.style.transform='scale(1)'">
             {% endif %}
             {% endfor %}
         </div>
         {% elsif first_project.image %}
         <img src="{{ first_project.image }}" alt="{{ first_project.title }}" style="max-width: 300px; margin: 10px 0; border-radius: 8px;">
         {% endif %}
         <p>{{ first_project.description | markdownify }}</p>
     </div>
    
    <div class="toggle-container">
        <button id="toggle-other-projects" onclick="toggleOtherProjects()" class="toggle-button">
            <span id="toggle-text">View more projects</span>
            <span id="toggle-arrow">▼</span>
        </button>
    </div>
    
    <div id="other-projects-content" class="fade-content" style="display: none;">
         {% for project in site.data.other_projects offset:1 %}
         <div class="project">
             <h4>{{ project.title }}</h4>
             {% if project.images %}
             <div class="image-gallery" style="display: flex; gap: 10px; margin: 10px 0; flex-wrap: wrap;">
                 {% for img in project.images %}
                 {% if img contains '.pdf' %}
                 {% assign pdf_filename = img | split: '/' | last | split: '.' | first %}
                 {% assign preview_path = 'pdf_previews/' | append: pdf_filename | append: '_preview.jpg' %}
                 <img src="{{ preview_path }}" alt="{{ project.title }} PDF Preview" 
                      onclick="openPdf('{{ img }}', '{{ project.title }}')"
                      style="max-width: 150px; height: 100px; object-fit: cover; border-radius: 6px; cursor: pointer; border: 2px solid #e9ecef; transition: all 0.2s ease;"
                      onmouseover="this.style.borderColor='#007bff'; this.style.transform='scale(1.02)'"
                      onmouseout="this.style.borderColor='#e9ecef'; this.style.transform='scale(1)'"
                      onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                 <div onclick="openPdf('{{ img }}', '{{ project.title }}')"
                      style="max-width: 150px; height: 100px; background: #f8f9fa; border: 2px solid #e9ecef; border-radius: 6px; cursor: pointer; display: none; flex-direction: column; align-items: center; justify-content: center; transition: all 0.2s ease;"
                      onmouseover="this.style.borderColor='#007bff'; this.style.transform='scale(1.02)'"
                      onmouseout="this.style.borderColor='#e9ecef'; this.style.transform='scale(1)'">
                     <div style="font-size: 24px; margin-bottom: 5px;">📄</div>
                     <div style="font-size: 10px; text-align: center; color: #666;">PDF</div>
                 </div>
                 {% else %}
                 <img src="{{ img }}" alt="{{ project.title }}" 
                      onclick="openImageModal('{{ img }}', '{{ project.title }}')"
                      style="max-width: 150px; height: 100px; object-fit: cover; border-radius: 6px; cursor: pointer; border: 2px solid #e9ecef; transition: all 0.2s ease;"
                      onmouseover="this.style.borderColor='#007bff'; this.style.transform='scale(1.02)'"
                      onmouseout="this.style.borderColor='#e9ecef'; this.style.transform='scale(1)'">
                 {% endif %}
                 {% endfor %}
             </div>
             {% elsif project.image %}
             <img src="{{ project.image }}" alt="{{ project.title }}" style="max-width: 300px; margin: 10px 0; border-radius: 8px;">
             {% endif %}
             <p>{{ project.description | markdownify }}</p>
         </div>
         {% endfor %}
    </div>
</section>

<!-- Image Modal -->
<div id="imageModal" style="display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0,0,0,0.8); cursor: pointer;" onclick="closeImageModal()">
    <div style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); max-width: 90%; max-height: 90%;">
        <img id="modalImage" src="" alt="" style="max-width: 100%; max-height: 100%; border-radius: 8px; box-shadow: 0 4px 20px rgba(0,0,0,0.5);">
        <div id="modalCaption" style="color: white; text-align: center; margin-top: 10px; font-size: 16px; font-weight: bold;"></div>
    </div>
    <span style="position: absolute; top: 20px; right: 35px; color: white; font-size: 40px; font-weight: bold; cursor: pointer;" onclick="closeImageModal()">&times;</span>
</div>

<script>
function toggleOtherProjects() {
    const content = document.getElementById('other-projects-content');
    const toggleText = document.getElementById('toggle-text');
    const toggleArrow = document.getElementById('toggle-arrow');
    const button = document.getElementById('toggle-other-projects');
    
    if (content.style.display === 'none') {
        content.style.display = 'block';
        content.style.opacity = '0';
        content.style.transform = 'translateY(-10px)';
        
        // Trigger fade-in animation
        setTimeout(() => {
            content.style.transition = 'opacity 0.3s ease, transform 0.3s ease';
            content.style.opacity = '1';
            content.style.transform = 'translateY(0)';
        }, 10);
        
        toggleText.textContent = 'Hide additional projects';
        toggleArrow.textContent = '▲';
        button.classList.add('active');
    } else {
        content.style.transition = 'opacity 0.3s ease, transform 0.3s ease';
        content.style.opacity = '0';
        content.style.transform = 'translateY(-10px)';
        
        setTimeout(() => {
            content.style.display = 'none';
        }, 300);
        
        toggleText.textContent = 'View more projects';
        toggleArrow.textContent = '▼';
         button.classList.remove('active');
     }
 }

function toggleAiSafetyProjects() {
    const content = document.getElementById('ai-safety-projects-content');
    const toggleText = document.getElementById('toggle-ai-safety-text');
    const toggleArrow = document.getElementById('toggle-ai-safety-arrow');
    const button = document.getElementById('toggle-ai-safety-projects');
    
    if (content.style.display === 'none') {
        content.style.display = 'block';
        content.style.opacity = '0';
        content.style.transform = 'translateY(-10px)';
        
        // Trigger fade-in animation
        setTimeout(() => {
            content.style.transition = 'opacity 0.3s ease, transform 0.3s ease';
            content.style.opacity = '1';
            content.style.transform = 'translateY(0)';
        }, 10);
        
        toggleText.textContent = 'Hide additional projects';
        toggleArrow.textContent = '▲';
        button.classList.add('active');
    } else {
        content.style.transition = 'opacity 0.3s ease, transform 0.3s ease';
        content.style.opacity = '0';
        content.style.transform = 'translateY(-10px)';
        
        setTimeout(() => {
            content.style.display = 'none';
        }, 300);
        
        toggleText.textContent = 'View more projects';
        toggleArrow.textContent = '▼';
        button.classList.remove('active');
    }
}

function openImageModal(imageSrc, imageTitle) {
    const modal = document.getElementById('imageModal');
    const modalImg = document.getElementById('modalImage');
    const modalCaption = document.getElementById('modalCaption');
    
    modal.style.display = 'block';
    modalImg.src = imageSrc;
    modalCaption.textContent = imageTitle;
    
    // Prevent body scrolling when modal is open
    document.body.style.overflow = 'hidden';
}

function openPdf(pdfSrc, pdfTitle) {
    // Open PDF in a new tab
    window.open(pdfSrc, '_blank');
}

function closeImageModal() {
    const modal = document.getElementById('imageModal');
    modal.style.display = 'none';
    
    // Restore body scrolling
    document.body.style.overflow = 'auto';
}

// Close modal when pressing Escape key
document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape') {
        closeImageModal();
    }
});
</script>