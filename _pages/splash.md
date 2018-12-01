---
layout: splash
permalink: /
header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/splash/kinabalu.jpg
actions:
  - label: "Download"
    url: "https://github.com/mmistakes/minimal-mistakes/"
excerpt: "This is the website of Adrian Ng. Here you will see examples of my _Java_ projects and some notes on working with _SQL_ queries."

intro: 
  - excerpt: '__Java projects.__'
feature_row:
  - image_path: assets/images/unsplash-gallery-image-1-th.jpg
    alt: "Option Pricer"
    title: "Option Pricer"
    excerpt: "The implementation of three models for pricing options: Binomial Trees, Monte Carlo simulation, and Black Scholes equations"
    url: "/java/options/"
    btn_label: "Read More"
    btn_class: "btn--primary"    
  - image_path: /assets/images/unsplash-gallery-image-2-th.jpg
    image_caption: "Image courtesy of [Unsplash](https://unsplash.com/)"
    alt: "Value at Risk"
    title: "Value at Risk"
    excerpt: "How bad could it get for our financial portfolio? This dissertation project looks at a number of ways of estimating VaR."
    url: "#test-link"
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
    title: "Placeholder Image Right Aligned"
    excerpt: 'This is some sample content that goes here with **Markdown** formatting. Right aligned with `type="right"`'
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