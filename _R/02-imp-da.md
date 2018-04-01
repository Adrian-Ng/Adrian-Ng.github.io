---
title: "R Language: Implementing Discriminant Analysis"
permalink: /R/imp-da/
excerpt: "An Implmentation of Discriminant Analysis in R Language by Adrian Ng"
toc: true
mathjax: true
---

## Intro

There's nothing here yet. 

### Bayes Classifier

$$
p_k(x) = (Y = k\vert X =x) = \frac{\pi_k f_k(x)}{\sum_{l=1}^K \pi_l f_l(x)}
$$

### Assumption of X

$$
f_k(x) = \frac{1}{\sqrt{2\pi} \sigma_k} exp \left(-\frac{1}{2\sigma_k^2} (x-\mu_k)^2 \right)
$$

## Linear Discriminant Analysis

### Classifier

$$
\delta(x) = \frac{\mu_k}{\sigma^2}x-\frac{\mu_k^2}{2\sigma^2} + \log \pi_k
$$

### Variance

$$
\sigma^2 = \frac{1}{n-k} \sum_{k=1}^K \sum_{i:y_i =k} (x_i - \mu\hat_k)^2
$$

### Classifier for multinomial classification

$$
\delta_k(x) = x^T\Sigma^{-1} \mu_k - \frac{1}{2}\mu^T_k\Sigma^{-1}\sigma_k + \log \pi_k
$$

## Quadratic Discriminant Analysis

### Classifer

$$
\delta_k(x) = -\frac{1}{2} log\vert\Sigma_k\vert - \frac{1}{2}(x-\mu_k)^T\Sigma_k^{-1}(x-\sigma_k) + \log\pi_k
$$


