---
title: "Options Pricing: Binomial Trees"
permalink: /java/options/trees/
excerpt: "Pricing European and American options using Binomial Trees"
toc: true
mathjax: true
---

## Download

[Github](https://github.com/Adrian-Ng/OptionPricer){: .btn .btn--success .btn--large}

## Example

### Parameters

Consider an option with the strike price $$X = 120$$ maturing in $$T = 3$$ months on a stock worth $$S = 115$$ having volatility $$\sigma = 30%$$ and interest rate $$r = 15%$$.

We shall use a three-step bionimal model, with each time step representing one month.

$$\Delta t = 1/12 = 0.8333$$

### Building a Tree of Stock Prices

The above stock price will either go up or down.

{% include figure image_path="/assets/images/binomial/simplestockprice.png" %}

In this model, these up/down movements are defined as:

$$
u = e^{\sigma\sqrt{\Delta t}}\\
d = e^{-\sigma\sqrt{\Delta t}} = \frac{1}{u}\\
$$

where $$\sigma$$ is the volatility and $$\Delta t$$ is the time step.

Applying our parameters, we get

$$
u = e^{0.3\sqrt{0.08333}} = 1.0905\\
d = 1/1.0905 = 0.9170\\
$$

To get the stock price at the next time step we compute both $$S_0 \cdot u$$ and $$S_0 \cdot d$$. 

That is:

$$
S_0 \cdot u = 115 \times 1.0905 = 125.4074
S_0 \cdot d = 115 \times 0.9170 = 105.455
$$

We can represent this tree using a matrix.

$$
\begin{array}{|c|c|}
\hline
115 & 125.4074   \\
& 105.455  \\
\hline
\end{array}
$$



Doing this for every timestep, we build our tree iteratively until $$t = T$$.

$$
\begin{array}{|c|c|c|c|}
\hline
115 & 125.4074 & 136.7569 & 149.1334  \\
 & 105.455 & 115 & 125.4075 \\
 &  & 96.7022 & 105.455 \\
 &  &  & 88.6759 \\
\hline
\end{array}
$$

### Implementation

We can populate a matrix of stock prices in Java using a two-dimensional array.

```java
private double[][] stockPrices(double S0, double u, double d, int T) {
    double[][] stockPrice = new double[T][T];
    stockPrice[0][0] = S0;
    for (int hori = 1; hori < T; hori++) {
        // compute increase by u on the extreme side only
        stockPrice[0][hori] = stockPrice[0][hori - 1] * u;
        for (int vert = 1; vert < T; vert++)
            // compute all decrease by d
            stockPrice[vert][hori] = stockPrice[vert - 1][hori - 1] * d;
    }
    return stockPrice;
}
```

This will result in $$n = T$$ predictions of $$S_T$$. Now we can compute our option prices.





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

Consider some derivative, such as a _call_ or _put_, which expires at time $$T$$ and is dependent on a stock $$S_t$$.

The stock price can go up from $$S_0 \rightarrow S_0\cdot u$$.

Or down from $$S_0 \rightarrow S_0 \cdot d$$

Likewise if the derivative initially costs $$f$$ it can go to $$f_u$$ or $$f_d$$. These 

We can choose delta such that the portfolio is riskless:

$$
\Delta = \frac{f_u - f_d}{S_0 u- S_0 d}
$$

The financial meaning of this is that it is sensitive to change in derivative price with respect to share price.



$$
f = e^{r\Delta t}(pf_u+(1-p)f_d)
$$



## Stock Prices

Suppose $$S_0=50$$ is the initial stock price.

On the next step, prices will increase via $$S_0\cdot u$$ and decrease via $$S_0\cdot d$$.

Where:



We iterate through every step until maturity $$t = T$$. 
At this point we will have evaluated every stock price in the tree within our time horizon.

## Option Prices

### At Maturity

### Before Maturity

Now we iterate backwards through the tree towards.
At each stock price we compute an option price using risk-neutral valuation.

