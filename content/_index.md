---
date: "2022-10-24"
design:
  spacing: 6rem
sections:
- block: resume-biography-3
  content:
    button:
      text: View CV
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
      value: Pre-Doctoral Researcher
      detail: Indian Institute of Science
    - label: Education
      value: BTech in Computer Engineering
      detail: K.J. Somaiya School of Engineering · 2025
    - label: Focus
      value: Learning-based Navigation policies
      detail: Multi-modal learning · Embodied AI · Robot learning
    - label: Thinking about
      value: How do we get navigation policies to take inputs from multiple sensors publishing at different Hz and run reliably?
      detail: Multi-modal representation learning · long-horizon decision making · out-of-distribution generalization
    news:
    - date: September 2026
      text: Heading to IROS 2026 to present MAMMOTH.
      current: true
    - date: July 2026
      text: MAMMOTH was accepted to IROS 2026 as a first-author paper.
    - date: Jun 2025
      text: Joined the AIRL @ Indian Institute of Science as a researcher in autonomous navigation.
  design:
    css_class: profile-highlights-section
- block: research-publications
  content:
    text: "I'm a pre-doctoral researcher at the Indian Institute of Science, working on multi-modal end-to-end navigation policies for outdoor autonomous mobility. My research focuses on the intersection of machine learning and robotics, with an emphasis on large-scale robot learning, out-of-distribution generalization, long-horizon decision making, multi-modal representation learning, and continual learning.\n\nPlease reach out to collaborate! \U0001F603"
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
