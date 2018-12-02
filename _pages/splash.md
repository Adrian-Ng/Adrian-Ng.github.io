---
layout: splash
permalink: /
header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/splash/kinabalu.jpg
  actions:
    - label: "LinkedIn"
      url: "https://www.linkedin.com/in/adrian-ng-2a2aa62b/"
    - label: "GitHub"
      url: "https://github.com/Adrian-Ng/"
    - label: "contact@adrian.ng"
      url: "contact@adrian.ng"
excerpt: "This is the website of Adrian Ng. _My_ website. Here you will see examples of my _Java_ projects and some notes on working with _SQL_ queries. Along the way, you'll also get to see pictures I took from various _mountains_. Like myself, website is a work in progress."

intro: 
  - excerpt: '__Java projects.__'
feature_row:
  - image_path: assets/images/splash/optionpricer.jpg
    image_caption: "Borodur"  
    alt: "Option Pricer"
    title: "Option Pricer"
    excerpt: "The implementation of three models for pricing options: Binomial Trees, Monte Carlo simulation, and Black Scholes equations"
    url: "/java/options/"
    btn_label: "Read More"
    btn_class: "btn--primary"    

  - image_path: /assets/images/splash/var.jpg    
    image_caption: "Kinabalu"  
    alt: "Value at Risk"
    title: "Value at Risk"
    excerpt: "How bad could it get for our financial portfolio? This _dissertation project_ looks at a number of ways of estimating __VaR__."
    url: "/java/var/"
    btn_label: "Read More"
    btn_class: "btn--primary"

  - image_path: /assets/images/unsplash-gallery-image-3-th.jpg
    title: "Placeholder 3"
    excerpt: "This is some sample content that goes here with **Markdown** formatting."
feature_row2:
  - image_path: /assets/images/unsplash-gallery-image-2-th.jpg
    alt: "placeholder image 2"
    title: "Placeholder Image Left Aligned"
    excerpt: 'This is some sample content that goes here with **Markdown** formatting. Left aligned with `type="left"`'
    url: "#test-link"
    btn_label: "Read More"
    btn_class: "btn--primary"
feature_row3:
  - image_path: /assets/images/unsplash-gallery-image-2-th.jpg
    alt: "placeholder image 2"
    title: "Hadoop"
    excerpt: 'Coming Soon'
    url: "#test-link"
    btn_label: "Read More"
    btn_class: "btn--primary"
feature_row4:
  - image_path: /assets/images/unsplash-gallery-image-2-th.jpg
    alt: "placeholder image 2"
    title: "Placeholder Image Center Aligned"
    excerpt: 'This is some sample content that goes here with **Markdown** formatting. Centered with `type="center"`'
    url: "#test-link"
    btn_label: "Read More"
    btn_class: "btn--primary"
   
---

{% include feature_row id="intro" type="center" %}

# Java Projects

{% include feature_row %}

{% include feature_row id="feature_row2" type="left" %}

{% include feature_row id="feature_row3" type="right" %}

{% include feature_row id="feature_row4" type="center" %}

# SQL Notes