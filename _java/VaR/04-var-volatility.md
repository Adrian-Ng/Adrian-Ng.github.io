---
title: "Value at Risk: Volatility"
permalink: /java/var/volatility/
excerpt: "Computing volatility in the application of Value at Risk"
toc: false
mathjax: true
classes: wide
---





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