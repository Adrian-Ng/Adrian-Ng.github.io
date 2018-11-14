---
title: "Options Pricing: Binomial Trees"
permalink: /java/options/trees/
excerpt: "Pricing European and American options using Binomial Trees"
toc: true
mathjax: true
---

## Download

[Github](https://github.com/Adrian-Ng/OptionPricer){: .btn .btn--success .btn--large}

## Intro

A stock price can move up and down. 
But we don't know which direction it's going to go. 
This is the problem with pricing options.

Consider the following:

{% include figure image_path="/assets/images/binomial/simplestockprice.png" %}

Presently a share is worth $20, but in three-months it could be either $22 or $18.
This is a simplistic model. But it captures our uncertainty.

Now let's consider a three-month call option with a strike price $$X = 21$$.

{% include figure image_path="/assets/images/binomial/simpleoptionprice.png" %}

At maturity, the value of the option will either be $1 or $0. But what will the value of my portfolio be?


If $$S_T = 22$$ then my portfolio is valued at $$V = 22\Delta -1$$. 
But if $$S_T = 18$$ then $$V = 18\Delta$$.  


## Risk Neutral World

$$
\Delta = \frac{f_u - f_d}{S_0 u0 S_0 d}
$$

## Generalisation

$$
f = e^{r\Delta t}(pf_u+(1-p)f_d)
$$



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

