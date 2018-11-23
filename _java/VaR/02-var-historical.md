---
title: "Historical Simulation"
permalink: /java/var/historical/
excerpt: "Estimating Value at Risk via Historical Simulation"
toc: true
mathjax: true
---

For each of these price changes $$\Delta S_i$$, we compute the difference between the current value of our portfolio and the future value our portfolio to build a sample of changes $$\Delta\Pi$$.
We then sort $$\Delta\Pi$$ in order of largest to smallest, positive to negative.
If, for example, our confidence level is $$c=99\%$$.
Our estimate of VaR occurs at the cut-off point in $$\Delta\Pi$$ at $$99\%$$.
$$99\%$$ of 1000 samples is 990, so we take $$\Delta\Pi_{990}\sqrt{\Delta t}$$, where $$\Delta t$$ is the time horizon.


## Algorithm


1. Value today's portfolio from stock prices and deltas
2. for each asset:
  a. Calculate daily returns from historical data
	b) Predict tomorrow's prices from returns and today's stock prices
3. Value tomorrow's portfolio $$\Pi^{tomorrow}$$ from predicted stock prices and deltas
4. $$\Delta\Pi = \Pi^{tomorrow} - \Pi^{today}$$
5. Sort $$\Delta\Pi$$ ascending
6. $$\mathit{VaR} \leftarrow \Delta\Pi_{99\%}\sqrt{\Delta t}$$


## Stream

```java
ArrayList<Double> tomorrowPosition = percentageChanges
        .stream()
        .map(i -> (i + 1) * currentPrice * hashStockDeltas.get(sym))
        .collect(Collectors.toCollection(ArrayList::new));
```

## Estimating VaR

```java
        Collections.sort(tomorrowPortfolio);
        double index = (1 - Confidence) * size;
        double VaR = (currentPortfolio - tomorrowPortfolio.get((int) index)) * TimeHorizon;
        return VaR;
```


## Output

```
	Historical Simulation
		VaR: 3383.974036
```