---
layout: splash
title: "Hi"
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
      url: "mailto:contact@adrian.ng"
excerpt: "This is the website of __Adrian Ng__. _My_ website. Here you will see examples of my _Java projects_ and my notes on writing _SQL_. 

Along the way, you'll also visit some places I photographed long ago. Like myself, this website is very much a work in progress."

java:
  - excerpt: "After cutting my teeth on _Java_ during my _MSc_ dissertation project, I found it stimulating and a joy to work with. Since then I have been fortifying my Java. My code makes use of, for instance, _interfaces & abstract_ classes, _Java 8 Streams_, and multithreading in the form of _callable futures_."

feature_row:
  - image_path: assets/images/splash/optionpricer.jpg
    image_caption: "Borobudur"  
    alt: "Option Pricer"
    title: "Option Pricer"
    excerpt: "The implementation of three models for pricing options: __Binomial Trees__, __Monte Carlo__ simulation, and __Black Scholes__ equations"
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

  - image_path: /assets/images/splash/hadoop.jpg
    image_caption: "Kinabalu"  
    alt: "Apache Spark"
    title: "Apache Spark"      
    excerpt: "Coming soon... Having worked on some Hadoop projects in the past, it should be interesting to try to translate these to Spark."

feature_row2:
  - image_path: /assets/images/splash/yahoofinance.jpg
    image_caption: "Skaftafellsjökull"  
    alt: "Yahoo Finance"
    title: "Fun with the Yahoo Finance API"
    excerpt: 'As of March 2018, something happened to Google Finance - it got taken to the __chopping board__ and is now a miserable husk of its former self!
Long gone are the days where one could simply hook into the API and download a fat, juicy csv-file of historical stock price data... or a sensible JSON of option prices.

Thankfully there are many alternatives out there, such as the __Yahoo Finance API__'
    url: "/java/yahoofinance/"
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
sql:
  - excerpt: "In a past life, my expertise lay in working with SQL databases and writing queries and stored procedures. [Here are some of my notes](http://adrian.ng/SQL/ddl/intro/)"  

datascience:
  - excerpt: "In 2017, I graduated from Royal Holloway with an MSc in Data Science. I have no aspirations to be a _Data Scientist_. However, I did enjoy the experience of writing my own implementations of algorithms such as _K Nearest Neighbours_, _Neural Networks_, and _Hierarchical Clustering_ in __R__. Also used was __MATLAB__, which no-one uses so projects worked on in this language will be added last."
---



## [Java Projects](/java/)

{% include feature_row id="java" type="center" %}

{% include feature_row %}

{% include feature_row id="feature_row2" type="left" %}


## SQL Notes

{% include feature_row id="sql" type="center" %}

## Data Science

{% include feature_row id="datascience" type="center" %}

