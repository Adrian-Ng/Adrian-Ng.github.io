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

### Stock Prices

Suppose $$S_0=50$$ is the initial stock price.

On the next step, prices will increase via $$S_0\cdot u$$ and decrease via $$S_0\cdot d$$.

Where:

$$
u = e^{\sigma\sqrt{\Delta t}}\\
d = e^{-\sigma\sqrt{\Delta t}} = \frac{1}{u}\\
$$

