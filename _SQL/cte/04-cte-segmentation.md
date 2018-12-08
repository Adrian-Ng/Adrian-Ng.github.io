---
title: "The Common Table Element"
permalink: /SQL/cte/Segmentation/
excerpt: "Segmentation"
toc: true
mathjax: true
header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/headers/cte.jpg
---

## Business "reasons"

Suppose for _business reasons_ we need to segment a dataset into buckets of different sizes to perform an A/B test.

In this example, we generate two test splits of 20% each and a 60% validation set.
The validation set is where we would apply whichever logic won in the A/B test


### SQL

We're making use of two functions.

`NTILE(5)` is a windowed function which allows us to split our data set into 5 groups.

`NEWID()` is used to randomize the sampling on each transaction.

Then in the main body of the query we use a case statement to reduce the 5 groups to our final splits.


```sql
WITH cteSplit AS (
	SELECT
		Email
	,	NTILE(5) OVER (ORDER BY NEWID()) AS RN
	FROM music.account
	)
SELECT
	Email
,	CASE 
		WHEN RN = 1 THEN 'Split A'
		WHEN RN = 2 THEN 'Split B'
		ELSE 'Validation'
	END AS Split
INTO #split
FROM cteSplit;
```
Warming: `NEWID()` produces a different result at each transaction!
{: .notice--warning}

### Percentage Distribution

We can check the percentage distribution like so:


```sql
SELECT
	Split
,	COUNT(*)*100.0/SUM(COUNT(*)) OVER() AS Pcnt
FROM #split
GROUP BY Split;
```	

### Output

$$
\begin{array}{|c|c|}
\hline
\text{Split} & \text{Pcnt }\\ 
\hline
\text{Split A} & 20.000000000000\\
\text{Split B} & 20.000000000000 \\
\text{Validation} & 60.000000000000 \\
\hline
\end{array}
$$



