---
title: "Analytical Approach"
permalink: /java/var/analytical/
excerpt: "Estimating Value at Risk via the Analytical Approach"
toc: false
mathjax: true
---

### Percentage Changes

```java
double[] percentageChanges = PercentageChange.getArray(stock.getHistory());
```

### Volatility factory

Before we can return volatility, we instantiate

```java
VolatilityFactory volatilityFactory = new VolatilityFactory();
VolatilityAbstract volatility = volatilityFactory.getType(volatilityMeasure);
double[][] correlationMatrix = volatility.getCorrelationMatrix(matrixPcntChanges);
```
