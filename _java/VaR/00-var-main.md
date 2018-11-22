---
title: "Value at Risk"
permalink: /java/var/intro/
excerpt: "An intro to VAR by Adrian Ng"
toc: false
mathjax: true
classes: wide
header:
  image: /assets/var/Normal.png
---

This project looks at three ways of computing estimating Value at Risk (VaR) using Java.
Some may take probabilistic assumptions and/or sample from simulated distributions.

In all cases, we take the parameters of our approaches from real-world historical market data, from _Yahoo Finance_.

* [Historical Simulation](/java/var/historical/){: .btn .btn--warning .btn--x-large}

* [Monte Carlo Simulation](/java/var/montecarlo/){: .btn .btn--danger .btn--x-large}

* [Analytical Approach](/java/var/analytical/){: .btn .btn--info .btn--x-large}

The results of each of these implmentations are compared using __Back Testing__.

* [Back Testing](/java/var/backtest/){: .btn .btn--inverse .btn--x-large}

## Download

[GitHub](https://github.com/Adrian-Ng/ValueAtRisk){: .btn .btn--success .btn--large}

## Background

For a given a portfolio of investments there is an associated risk. 
However, there are many measures of risk (such as Greek letters) that simply describe different aspects of risk in a portfolio of derivatives. 
The goal of Value at Risk (VaR) is to provide an estimate of risk that summarises all aspects of risk into a single figure.

This figure simply answers the question: how bad _could_ it get? 
An answer is provided with respect to two parameters: the __time horizon__ and __confidence level__. 
That is, we are $$x%$$ sure that our portfolio will not lose more than a certain amount over the next %%N%% days. 
That certain amount is our VaR estimate.

This estimate is widely used in industry. 
Take for instance an investment bank. 
People deposit their money into this bank and, in turn, the bank invests this money in the stock market and earns money on the returns. 
An investment with high returns is highly risky. 
The bank needs to keep a certain amount of cash in reserve to mitigate this risk. 
The size of this reserve is proportional to the bank’s exposure to risk, i.e. the VaR estimate.

## Project Structure

## Main Class

### Utils


## PercentageChange

In order to estimate _variance_ and _volatilities_, we take the assumption that the __percentage changes__ between the stock prices on each day can be modelled on the __standard Gaussian Distribution__, $$\Phi(0,1)$$.

$$
\frac{S_{t-1}-S_{t}}{S_{t}}
$$



### getArrayList

We pass a collection of `HistoricalQuote` to `getArrayList`, which returns a collection of `Double` in an `ArrayList`.
That is, this is a collection of historical price data for a given stock.

In this method, we iterate through `HistoricalQuote` and invoke `getClose()`, which returns the stock price at the market close in the form of a `BigDecimal` type.
At each iteration, we take the previous and current `BigDecimal` and compute the percentage change.
Because working with `BigDecimal` is computationally expensive (=slow), we cast each result to `double`.

```java
public static ArrayList<Double> getArrayList(List<HistoricalQuote> historicalQuotes) {
    ArrayList<Double> percentageChange = new ArrayList<>();
    Iterator<HistoricalQuote> iterator = historicalQuotes.iterator();
    BigDecimal a = iterator.next().getClose();
    while (iterator.hasNext()){
        BigDecimal b = iterator.next().getClose();
        BigDecimal PriceDiff = a
                                .subtract(b)
                                .divide(a, RoundingMode.HALF_UP);
        percentageChange.add(PriceDiff.doubleValue());
        a = b;
    }
    return percentageChange;
}
```


### getArray

```java
public static double[] getArray(List<HistoricalQuote> historicalQuotes) {
    ArrayList<Double> percentageChange = getArrayList(historicalQuotes);
    int size = percentageChange.size();
    double[] doubles = new double[size];

    for (int i = 0; i < size; i++)
        doubles[i] = percentageChange.get(i);

    return doubles;
}
```

## Abstract Classes

* `RiskMeasure.java`
* `VolatilityAbstract.java`

### RiskMeasure

```java
public abstract class RiskMeasure extends VaR {
    
    abstract double getVar();

}
```

### Volatility

The only abstract method defined in `VolatilityAbstract.java` is as follows:

```java
abstract public double getVariance(double[] xVector, double[] yVector);
```





