---
date: "2022-10-24"
design:
  spacing: 6rem
sections:
- block: resume-biography-3
  content:
    button:
      text: Download CV
      url: https://drive.google.com/file/d/18puzgt0tfvpZYk-wnqvfysl5HGL4aydx/view?usp=sharing
    text: ""
    username: admin
  design:
    background:
      color: black
      image:
        filename: stacked-peaks.svg
        filters:
          brightness: 1
        parallax: false
        position: center
        size: cover
    css_class: dark
- block: profile-highlights
  content:
    glance:
    - label: Current
      value: Researcher
      detail: Indian Institute of Science
    - label: Education
      value: BTech in Computer Engineering
      detail: K.J. Somaiya School of Engineering · 2025
    - label: Focus
      value: Off-road autonomous navigation
      detail: Multi-modal learning · Motion planning · Robot learning
    news:
    - date: 2026
      text: MAMMOTH was accepted to IROS 2026 as a first-author paper.
      current: true
    - date: 2026
      text: MS-DOTT, a large-scale multi-modal off-road dataset, was submitted to RAAI 2026.
      current: true
    - date: Jun 2025
      text: Joined the Indian Institute of Science as a researcher in autonomous navigation.
    - date: 2025
      text: Built and deployed end-to-end navigation models for an all-terrain vehicle at IISc.
  design:
    css_class: profile-highlights-section
- block: research-publications
  content:
    text: "I'm a researcher at the Indian Institute of Science, working on multi-modal
      end-to-end navigation policies for off-road autonomous mobility. My research
      interests include motion planning, multi-modal sensor fusion, and robot learning
      for outdoor, in-the-wild navigation.\n\nPlease reach out to collaborate \U0001F603"
    title: "Research & Publications"
    filters:
      folders:
      - publication
  design:
    css_class: mobile-content-gutter
    columns: 2
    fill_image: true
    view: article-grid
  id: papers
- block: minimal-experience
  content:
    username: admin
  design:
    date_format: January 2006
    is_education_first: false
  id: experience
- block: resume-skills
  content:
    title: Technical Skills
    username: admin
  design:
    css_class: mobile-content-gutter
    show_skill_percentage: false
title: ""
type: landing
---
