---
title: "Options Pricing: Binomial Trees"
permalink: /java/options/trees/
excerpt: "Pricing European and American options using Binomial Trees"
toc: true
mathjax: true
---

## Java

### Download

[Github](https://github.com/Adrian-Ng/OptionPricer)

## Stock Prices

Suppose $$S_0=50$$ is the initial stock price.

On the next step, prices will increase via $$S_0\cdot u$$ and decrease via $$S_0\cdot d$$.

Where:

$$
u = e^{\sigma\sqrt{\Delta t}}\\
d = e^{-\sigma\sqrt{\Delta t}} = \frac{1}{u}\\
$$

We iterate through every step until maturity $$t = T$$. 
At this point we will have evaluated every stock price in the tree within our time horizon.

## Option Prices

### At Maturity

### Before Maturity

Now we iterate backwards through the tree towards.
At each stock price we compute an option price using risk-neutral valuation.

$$
f = e^{r\Delta t}(pf_u+(1-p)f_d)
$$

