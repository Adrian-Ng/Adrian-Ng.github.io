---
title: "Historical Simulation"
permalink: /java/var/historical/
excerpt: "Estimating Value at Risk via Historical Simulation"
toc: true
mathjax: true
---

## Algorithm


1) Value today's portfolio from stock prices and deltas
2) for each asset:
	a) Calculate daily returns from historical data
	b) Predict tomorrow's prices from returns and today's stock prices
3) Value tomorrow's portfolio $$\Pi^{tomorrow$$} from predicted stock prices and deltas
4) $$\Delta\Pi = \Pi^{tomorrow} - \Pi^{today}$$
5) Sort $$\Delta\Pi$$ ascending
6) $$\mathit{VaR} \leftarrow \Delta\Pi_{99\%}\sqrt{\Delta t}


					\begin{algorithm}
						\caption{Historical method}
						\begin{algorithmic}[1]
						\Procedure{Historical}{}
							\label{alg:historical}							
							\State Value $\Pi^{today}$ from today's $S_i$
							\ForAll {assets $1 \leq i \leq n$}
							\State Calculate vector $\Delta S_i$ from historical data
							\State Apply all $\Delta S_i$ to $S_i$
							\EndFor
							\State Revalue for $\Pi^{tomorrow}$
							\State $\Delta\Pi = \Pi^{tomorrow}-\Pi^{today}$
							\State Sort $\Delta\Pi$ in descending order
							\State VaR $\gets \Delta\Pi_{99\%}\sqrt{\Delta t}$
						\EndProcedure
						\end{algorithmic}
					\end{algorithm}	


## Stream


## Output

```
	Historical Simulation
		VaR: 3383.974036
```