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
* $$a(1-c)$$ is the inverse cumulative distribution function of the Gaussian distribution, which gives us the percentile $$x_{(1-c)\%}$$.
* $$\delta t$$ is the time horizon
* $$\Delta$$ is number of stocks of that asset
* $$S$$ is the current price of that asset
* $$M$$ is the number of portfolio assets


We multiply these parameters by the covariance matrix. This formula is applicable to the single-stock and multi-stock portfolio. 

## getVar()


```java
public class Analytical extends RiskMeasure
```

In `Analytical.java`, we define our implementation of `getVar()` - a concrete version of the abstract method in `RiskMeasure.java`.

### Parameters

VaR takes two parameters, _Confidence_ and _Time Horizon_.
Suppose we take the confidence level $$c = 99%$$.
This means we are $$99%$$ sure that we won't lose more than $$V$$, our estimate of Value at Risk, within our _Time Horizon_, which is usually one day.

```java
double Confidence = Double.parseDouble(hashParam.get("Confidence"));
double TimeHorizon = Math.sqrt(Integer.parseInt(hashParam.get("TimeHorizonDays")));
```

These parameters are stored in a static `HashMap<String,String>` instance, `hashParam`. 
We must parse to convert to numeric values.

### Normal Distribution

Analytically, we look at this estimating VaR in terms of the standard Gaussian.



```java
NormalDistribution distribution = new NormalDistribution(0, 1);
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
double VaR = Math.sqrt(TimeHorizon)
        * riskPercentile
        * Math.sqrt(sum);
return VaR;
```
## Output

Assuming we have a portfolio consisting of 100 shares in _GOOG_, 200 in _MSFT_, and 100 in _AAPL_, with 95% confidence level and a time horizon of 1 day:

```
Analytical EW
	VaR: 3558.909656
Analytical EWMA
	VaR: 2555.420454
```

These results are computed using 5 years of historical data