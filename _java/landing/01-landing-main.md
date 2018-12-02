---
layout: splash
title: "Java Projects"
permalink: /java/
excerpt: "Java Projects so far"
toc: false

header:
  image: /assets/images/borodur.jpg

java:
  - excerpt: "I'm new to Java, initially cutting my teeth on it during my _MSc_ dissertation project. But I love it. Since then I have fortified my Java with, for instance, _interfaces & abstract_ classes, _Java 8 Streams_, and multithreading in the form of _callable futures_."

feature_row:
  - image_path: assets/images/splash/optionpricer.jpg
    image_caption: "Borobudur"  
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

  - image_path: /assets/images/splash/hadoop.jpg
    image_caption: "Kinabalu"  
    alt: "Hadoop"
    title: "Hadoop"  
    title: "Hadoop"
    excerpt: "Coming soon..."

feature_row2:
  - image_path: /assets/images/splash/yahoofinance.jpg
    image_caption: "Hardanger 2014"  
    alt: "Yahoo Finance"
    title: "Fun with the Yahoo Finance API"
    excerpt: 'As of March 2018, something happened to Google Finance - it got taken to the __chopping board__ and is now a miserable husk of its former self!
Long gone are the days where one could simply hook into the API and download a fat, juicy csv-file of historical stock price data... or a sensible JSON of option prices.

Thankfully there are many alternatives out there, such as the __Yahoo Finance API__'
    url: "/java/yahoofinance/"
    btn_label: "Read More"
    btn_class: "btn--primary"  
---

{% include feature_row id="java" type="center" %}

{% include feature_row %}

{% include feature_row id="feature_row2" type="left" %}



