---
title: "Options Pricing: Monte Carlo"
permalink: /java/options/montecarlo/
excerpt: "Pricing European and Asian options via diffusion or Monte Carlo method"
toc: true
mathjax: true
---


The behaviour of the price of a stock price can be described by the Generalisedd Wiener process.

$$
x(t + \Delta t) = x(t) + \mu\Delta t + \sigma dz
$$

Where $$dz$$ is the __Wiener Process__.

## Wiener Process

Let's start by constructing a _random walk_.

Suppose we have $$N$$ variables  which are independent and can take values of plus or minus 1 with equal probability of 0.5.

Let this variable be $$\epsilon_t \plusminus 1, text{with probability 0.5}$$

Each $$\epsilon_t$$ describes the up or down direction of the walk at each step.

We start at 0.

{% include figure image_path="/assets/images/random walk.png" alt="this is a placeholder image" caption="Random Walk" %}

W



