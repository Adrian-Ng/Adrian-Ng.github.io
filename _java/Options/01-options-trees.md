---
title: "Options Pricing: Binomial Trees"
permalink: /java/options/trees/
excerpt: "Pricing European and American options using Binomial Trees"
toc: true
mathjax: true
classes: wide
---

## Download

[Github](https://github.com/Adrian-Ng/OptionPricer){: .btn .btn--success .btn--large}

## Building a Tree of Stock Prices

### Parameters

Consider an option with the strike price $$X = 120$$ maturing in $$T = 3$$ months on a stock worth $$S = 115$$ having volatility $$\sigma = 30%$$ and interest rate $$r = 15%$$.

We shall use a three-step bionimal model, with each time step representing one month.

$$\Delta t = 1/12 = 0.8333$$

### Example

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
S_0 \cdot u = 115 \times 1.0905 = 125.4074\\
S_0 \cdot d = 115 \times 0.9170 = 105.455
$$

We can represent this fledgling tree using a matrix.

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

We have now $$n = T+1$$ predictions of $$S_T$$.

### Implementation

We can populate this tree in Java using a two-dimensional array.

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

This method will return a matrix of stock prices of size $$T \times T$$


## Building a Tree of Option Prices

We now construct a second matrix of option prices.

{% include figure image_path="/assets/images/binomial/simpleoptionprice.png" %}

### Computing Payoff


Once again we seek to populate a matrix of size $$T \times T$$ iteratively. Only this time we move from right to left.

In the first step, we look at the stock prices at maturity and compute the _Pay-Off_.

$$
\begin{array}{|c|c|}
\hline
\text{Call} & \text{Put} \\
\hline 
MAX(S_T - X,0) & MAX(X - S_T, 0) \\
\hline
\end{array}
$$

We compute an option price for each value of $$S_T$$ we computed earlier, which, if the option is a _Call_, returns the following:

$$
\begin{array}{|c|c|c|c|}
\hline
? & ? & ? & 29.1334  \\
 & ? & ? & 5.4075 \\
 &  & ? & 0 \\
 &  &  & 0 \\
\hline
\end{array}
$$

And the following if the option is a _Put_:

$$
\begin{array}{|c|c|c|c|}
\hline
? & ? & ? & 0  \\
 & ? & ? & 0 \\
 &  & ? & 14.5402 \\
 &  &  & 31.3120 \\
\hline
\end{array}
$$

### Applying Discounting

Next we look at all stock prices prior to maturity $$t < T$$ and use the following formulas to iteratively compute option prices.

$$
f = e^{r\Delta t}(pf_u+(1-p)f_d)
$$

But note that for _American Puts_, we must consider __early exercise__ such that our option price is:

$$
f = MAX(e^{r\Delta t}(pf_u+(1-p)f_d), X - S_t)
$$

#### European & American Call

$$
\begin{array}{|c|c|c|c|}
\hline
6.8171 & 11.2264 & 18.2383 & 29.1334  \\
 & 1.5993 & 2.9400 & 5.4075 \\
 &  & 0 & 0 \\
 &  &  & 0 \\
\hline
\end{array}
$$

#### European Put

$$
\begin{array}{|c|c|c|c|}
\hline
8.0051 & 2.8603 & 0 & 0  \\
 & 14.5402 & 6.4490 & 0 \\
 &  & 23.2890 & 14.5402 \\
 &  &  & 31.3120 \\
\hline
\end{array}
$$

#### American Put

$$
\begin{array}{|c|c|c|c|}
\hline
7.4003 & 2.8603 & 0 & 0  \\
 & 13.1767 & 6.4490 & 0 \\
 &  & 21.7983 & 14.5402 \\
 &  &  & 31.3120 \\
\hline
\end{array}
$$



### Implementing Call Pricing

As the implementation of pricing a European Call the same as that for an American Put, we need only write one implementation.

Therefore we write the following method in `TreeAbstract.java`.

```java
private double computeCall(double[][] stockPrice, double strike, double interest, double p, double dt, int T) {
    double[][] optionPrice = new double[T][T];
    for(int hori = T-1; hori >= 0; hori--)
        for(int vert = hori; vert >= 0; vert--){
            // compute option prices at maturity
            if (hori == T -1)
                optionPrice[vert][hori] = Math.max(stockPrice[vert][hori]-strike,   0.0);
            // compute option prices prior to maturity
            else
                optionPrice[vert][hori] = Math.exp(-interest*dt)*((p*optionPrice[vert][hori+1])+(1-p)*optionPrice[vert+1][hori+1]);
        }
    return optionPrice[0][0];
}
```

### Implementing Put Pricing

As the implmentation for a European Put differs from the American Put, we place an abstract method in `TreeAbstract.java`.

```java
abstract public double computePut(double[][] stockPrice, double strike, double interest, double p, double dt, int T);
```

Then we let the concrete implementation of this method be defined in the concrete classes `TreeEuropean.java` and `TreeAmerican.java`.

#### TreeEuropean.java

```java
@Override
public double computePut(double[][] stockPrice, double strike, double interest, double p, double dt, int T) {
    double[][] optionPrice = new double[T][T];
    for(int hori = T-1; hori >= 0; hori--)
        for(int vert = hori; vert >= 0; vert--){
            // compute option prices at maturity
            if (hori == T -1)
                optionPrice[vert][hori] = Math.max(strike-stockPrice[vert][hori],0.0);
                // compute option prices prior to maturity
            else
                optionPrice[vert][hori] = Math.exp(-interest*dt)*((p*optionPrice[vert][hori+1])+(1-p)*optionPrice[vert+1][hori+1]);
        }
     return optionPrice[0][0];
}
```

#### American 
```java
@Override
public double computePut(double[][] stockPrice, double strike, double interest, double p, double dt, int T) {
    double[][] optionPrice = new double[T][T];
    for(int hori = T-1; hori >= 0; hori--)
        for(int vert = hori; vert >= 0; vert--){
            // compute option prices at maturity
            if (hori == T -1)
                optionPrice[vert][hori] = Math.max(strike-stockPrice[vert][hori],0.0);
            // compute option prices prior to maturity
            else
                optionPrice[vert][hori] = Math.max(
                                                Math.exp(-interest*dt)*((p*optionPrice[vert][hori+1])+(1-p)*optionPrice[vert+1][hori+1])
                                            ,   strike-stockPrice[vert][hori]);
        }
    return optionPrice[0][0];
}
```


