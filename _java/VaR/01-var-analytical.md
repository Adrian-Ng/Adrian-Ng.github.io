---
title: "Analytical Approach"
permalink: /java/var/analytical/
excerpt: "Estimating Value at Risk via the Analytical Approach"
toc: true
mathjax: true
classes: wide
---

In the __Analytical Approach__ we have a direct formula for estimating VaR:

$$
\mathit{VaR} = -\alpha(1-c)(\Delta t)^{1/2}\sqrt{\sum_{j=1}^M\sum_{i=1}^M\Pi_i\Pi_j\Sigma_{ij}} 
$$

This is applicable to the single-stock and multi-stock portfolio.


```java
double sum = 0.0;
for (int i = 0; i < countAsset; i++)
    for (int j = 0; j < countAsset; j++)
        sum += stockDelta[i]
                * stockDelta[j]
                * currentPrices[i]
                * currentPrices[j]
                * covarianceMatrix[i][j];
//Computer VaR
double VaR = Math.sqrt(TimeHorizon)
        * riskPercentile
        * Math.sqrt(sum);
return VaR;
```