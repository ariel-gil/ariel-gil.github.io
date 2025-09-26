---
layout: default
title: Misc
description: Personal hobbies and interests - hiking, biking, motorcycles, cars, metalworking, and more.
---

{% for section in site.data.misc_sections %}
<section id="{{ section.title | downcase | replace: ' ', '-' | replace: '&', '' }}">
    <h3>{{ section.title }}</h3>
    <p>{{ section.description }}</p>
    
    {% if section.images %}
    <div class="image-gallery" style="display: flex; gap: 10px; margin: 10px 0; flex-wrap: wrap;">
        {% for img in section.images %}
        <img src="{{ img }}" alt="{{ section.title }}" 
             onclick="openImageModal('{{ img }}', '{{ section.title }}')"
             style="max-width: 200px; height: 150px; object-fit: cover; border-radius: 6px; cursor: pointer; border: 2px solid #e9ecef; transition: all 0.2s ease;"
             onmouseover="this.style.borderColor='#007bff'; this.style.transform='scale(1.02)'"
             onmouseout="this.style.borderColor='#e9ecef'; this.style.transform='scale(1)'">
        {% endfor %}
    </div>
    {% endif %}
</section>
{% endfor %}

<!-- Image Modal -->
<div id="imageModal" style="display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0,0,0,0.8); cursor: pointer;" onclick="closeImageModal()">
    <div style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); max-width: 90%; max-height: 90%;">
        <img id="modalImage" src="" alt="" style="max-width: 100%; max-height: 100%; border-radius: 8px; box-shadow: 0 4px 20px rgba(0,0,0,0.5);">
        <div id="modalCaption" style="color: white; text-align: center; margin-top: 10px; font-size: 16px; font-weight: bold;"></div>
    </div>
    <span style="position: absolute; top: 20px; right: 35px; color: white; font-size: 40px; font-weight: bold; cursor: pointer;" onclick="closeImageModal()">&times;</span>
</div>

<script>
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