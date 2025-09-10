---
layout: default
title: Home
description: AI Safety Researcher focusing on AI Risk management, standards and policy.
---

<section id="about">
    <h3>About Me</h3>
    <p>I am an AI Governance and Safety Researcher working on EU AI Act Risk Management Standards. I co-lead the <a href="https://ai-standards-lab.org/" target="_blank">AI Standards Lab</a>, a 501(c)(3) which I co-founded in late 2023.</p>
        
    <p>Originally a Mechatronics Engineer, I was an early team member an ophthalmic semi-autonomous surgical robotics startup, as well as in ML-based ultrasound diagnostics. My AI governance work is informed by my Risk Management experience, as well as technical and conceptual AI safety knowledge I've picked up along the way. Currently, I am exploring governance in shorter timelines and how I can best contribute to that space.</p>
    
    <p>In my free time, I mountain bike, rock climb, and dance salsa (when I'm not injured!). I also do occasional small design projects and 3D printing. You can see some of my previous engineering projects in <a href="https://www.coroflot.com/ArielGil" target="_blank">my design portfolio</a>.</p>
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