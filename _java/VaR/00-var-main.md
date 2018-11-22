---
title: "Value at Risk"
permalink: /java/var/intro/
excerpt: "An intro to VAR by Adrian Ng"
toc: false
mathjax: true
classes: wide
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

## Project Structure

## Main Class

### Utils


## PercentageChange

In order to estimate VaR, we take the assumption that the __percentage changes__ between the stock prices on each day can be modelled on the __standard Gaussian Distribution__, $$\Phi(0,1)$$.

### getArrayList

We pass a collection of `HistoricalQuote` to `getArrayList`, which returns a collection of `Double` in an `ArrayList`.

In this method, we iterate through `HistoricalQuote` and invoke `getClose()`, which emits a `BigDecimal`.
At each iteration, we take the previous and current `BigDecimal` and compute the percentage change, which is defined as follows:

$$
\frac{S_{t-1}-S_{t}}{S_{t}}
$$

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

Because working with `BigDecimal` is computationally expensive (=slow), we cast each result to `double`.

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

All remaining methods are identical in implementation across the child classes.
As such we define their bodies here. 
These classes are:

* `getCorrelationMatrix(double[][] matrix)`
* `getCovarianceMatrix(double[][] matrix)`
* `getCholeskyDecompositionMatrix(double[][] matrix)`

#### getCorrelationMatrix

#### getCovarianceMatrix

#### getCholeskyDecomposition

#### Factory

```java
public class VolatilityFactory {
    
    public VolatilityAbstract getType(String type) {
        if (type == null)
            return null;

        if (type.equals("EW"))
            return new VolatilityEW();

        if (type.equals("EWMA"))
            return new VolatilityEWMA();

        if (type.equals("GARCH"))
            return new VolatilityGARCH();

        return null;
    }
}
```


#### EW

```java
public class VolatilityEW extends VolatilityAbstract {
    @Override
    public double getVariance(double[] xVector, double[] yVector) {
        double sum = 0.0;
        int elements = xVector.length;
        for (int i = 0; i < elements; i++)
            sum += (xVector[i] * yVector[i]);
        return sum /(elements - 1);
    }
```

#### EWMA


```java
public class VolatilityEWMA extends VolatilityAbstract {
    private static double lambda;
    static {
        // Per JP Morgan's RiskMetrics 
        lambda = 0.94;
    }
    @Override
    public double getVariance(double[] xVector, double[] yVector) {
        int elements = xVector.length;
        double EWMA = xVector[elements - 1] * yVector[elements - 1];
        for (int i = 1; i < elements; i++)
            EWMA = (lambda * EWMA) + ((1-lambda) * xVector[elements -1 - i]* yVector[elements -1 - i]);
        return EWMA;
    }
}
```



