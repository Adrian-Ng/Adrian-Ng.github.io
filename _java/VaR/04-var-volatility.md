---
title: "Value at Risk: Variance and Volatility"
permalink: /java/var/volatility/
excerpt: "Computing volatility in the application of Value at Risk"
toc: false
mathjax: true
classes: wide
---

We calculate daily volatility as the _standard deviation_ of the __daily percentage change__ (= daily returns) of the stock price.
Our implement implmentation for returning the daily percentage change is defined in the class [PercentageChange.java](https://adrian.ng/java/var/intro/#percentagechange)

## Equal Weighted Variance

The squared volatility (=variance) can be calculated using a simple weighted model:

$$
\sigma^2_n = \frac{1}{m}\sum_{i=1}^m u^2_{n-i}
$$

This squares each percentage change and returns the average of all these elements.

```java
public class VolatilityEW extends VolatilityAbstract {
    @Override
    public double getVariance(double[] xVector, double[] yVector) {
        double sum = 0.0;
        int elements = xVector.length;
        for (int i = 0; i < elements; i++)
            sum += (xVector[i] * yVector[i]);
        return sum /elements;
    }
```

## Exponentially Weighted Moving Average



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

## GARCH
```java
//TODO
```

## VolatilityFactory

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
