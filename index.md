---
layout: default
title: Home
description: AI Safety Researcher focusing on AI Risk management, standards and policy.
---

<section id="about">
    <h3>About Me</h3>
    <p>I am Techical AI Governance Researcher, having worked on the EU AI Act standards and Codes of Practice. In 2023, I Co-founded the <a href="https://ai-standards-lab.org/" target="_blank">AI Standards Lab</a>, a 501(c)(3) supporting EU standards and the recent Codes of Practice. Currently, I am on a short sabatical, while staying as an Advisor/Board President</p>
        
    <p>Originally a Mechatronics Engineer, I was an early member an ophthalmic semi-autonomous surgical robotics startup. Later on, I worked in ML-based ultrasound diagnostics and laser eye surgery. My AI governance work is informed by my Risk Management experience, as well as technical and conceptual AI safety knowledge I've picked up along the way. Currently, I am exploring governance in shorter timelines and how I can best contribute to that space, as well as doing direct technical work.</p>
    
    <p>In my free time, I mountain bike, rock climb, hike, and dance salsa (when I'm not injured!). I also do occasional small design projects and 3D printing. You can see some of my previous engineering projects in <a href="https://www.coroflot.com/ArielGil" target="_blank">my design portfolio</a>.</p>
</section>

<section id="projects">
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