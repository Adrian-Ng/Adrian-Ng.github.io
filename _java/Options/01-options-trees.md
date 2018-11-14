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

At maturity, the value of the option will either be $1 or $0. But what will the value of my portfolio $$V$$ be?


If $$S_T = 22$$ then my portfolio is valued at $$V = 22\Delta -1$$. 

But if $$S_T = 18$$ then $$V = 18\Delta$$.  

Where $$\Delta$$ is the number of shares of this stock in your portfolio.

## Risk Neutral World

### Picking Delta

What number of shares should my portfolio have?

$$22\Delta -1 = 18\Delta$$

$$\Delta = 0.25$$

With this value of Delta, we have effectively elimnated risk from our portfolio as no matter whether the stock price goes up or down, the value of my portfolio will remain the same.

### Portfolio Valuation at Maturity

So the value of the portfolio in three months is:

$$22 \times 0.25 - 1 = 18 \times 0.25 = 4.5$$

### Portfolio Valuation at t = 0

When we apply discounting, the value of the portfolio is now:

$$
PV = 4.5e^{-0.12\times0.25}=4.3670
$$

Assuming an interest rate of 12% at continuous compounding.

### Option Pricing

Since:

* $$S_0 = 20$$
* $$\Delta = 0.25$$
* $$PV = 4.3670$$

$$PV = S_0\Delta - f$$

$$
\therefore
f = 20\times 0.25 - 4.3670 = 0.6330
$$


## Generalisation

Consider some derivate, such as a call or put.
It expires at time $$T$$ and is dependent on a stock $$S_t$$.

The price can go up from $$S_0 \rightarrow S_0\cdot u$$.

Or down from $$S_0 \rightarrow S_0 \cdot d$$

$$
\Delta = \frac{f_u - f_d}{S_0 u- S_0 d}
$$

$$
f = e^{r\Delta t}(pf_u+(1-p)f_d)
$$



## Java

### Download

[Github](https://github.com/Adrian-Ng/OptionPricer){: .btn .btn--success .btn--large}

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

