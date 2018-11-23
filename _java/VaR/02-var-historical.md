---
title: "Historical Simulation"
permalink: /java/var/historical/
excerpt: "Estimating Value at Risk via Historical Simulation"
toc: true
mathjax: true
---

## Algorithm


1. Value today's portfolio from stock prices and deltas
2. for each asset:
  a. Calculate daily returns from historical data
	b) Predict tomorrow's prices from returns and today's stock prices
3. Value tomorrow's portfolio $$\Pi^{tomorrow$$}$$ from predicted stock prices and deltas
4. $$\Delta\Pi = \Pi^{tomorrow} - \Pi^{today}$$
5. Sort $$\Delta\Pi$$ ascending
6. $$\mathit{VaR} \leftarrow \Delta\Pi_{99\%}\sqrt{\Delta t}$$


## Stream


## Output

```
	Historical Simulation
		VaR: 3383.974036
```