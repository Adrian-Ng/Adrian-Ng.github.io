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
\mathit{VaR} = -\alpha(1-c)(\Delta t)^{1/2}\sqrt{\sum_{j=1}^M\sum_{i=1}^M\Delta_i S_i\cdot\Delta_j S_j\Sigma_{ij}} \\
$$

where 
* $$a(1-c)$$ is the inverse cumulative distribution function of the Gaussian distribution, which gives us the percentile $x_{(1-c)\%}$.
* $$\delta t$$ is the time horizon
* $$\Delta$$ is number of stocks of that asset
* $$S$$ is the current price of that asset
* $$M$$ is the number of portfolio assets


We multiply these parameters by the covariance matrix. This formula is applicable to the single-stock and multi-stock portfolio. 

## Analytical.java

```java
public class Analytical extends RiskMeasure
```

```java
NormalDistribution distribution = new NormalDistribution(0, 1);
double Confidence = Double.parseDouble(hashParam.get("Confidence"));
double TimeHorizon = Math.sqrt(Integer.parseInt(hashParam.get("TimeHorizonDays")));
double riskPercentile = -distribution.inverseCumulativeProbability(1 - Confidence);
```
Note: `NormalDistribution` is part of the [Apache Commons Math Library](http://commons.apache.org/proper/commons-math/)
{: .notice--info}

```java
Double[] currentPrices = new Double[countAsset];
Double[] stockDelta = new Double[countAsset];

double[][] matrixPcntChanges = new double[countAsset][size];
try {
    for (int i = 0; i < countAsset; i++) {
        String sym = strSymbols[i];
        Stock stock = stockHashMap.get(sym);
        currentPrices[i] = stock.getQuote().getPreviousClose().doubleValue();
        stockDelta[i] = new Double(hashStockDeltas.get(sym));
        // get percentage changes of stock
        double[] percentageChanges = PercentageChange.getArray(stock.getHistory());
        matrixPcntChanges[i] = percentageChanges;
    }
} catch (Exception e) {
    e.printStackTrace();
}
```


```java
double[][] covarianceMatrix = new VolatilityFactory()
        .getType(volatilityMeasure)
        .getCovarianceMatrix(matrixPcntChanges);
```

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
## Output
