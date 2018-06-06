---
title: "CTEs: Deduping"
permalink: /SQL/cte/dedupe/
excerpt: "Using Common Table Elements to remove duplicates in SQL by Adrian Ng"
toc: False
mathjax: True
---

## Dedupe

Sometimes we don't want to have reptitions of certain values across multiple tuples in our dataset.
For instance, we might not want to see an email address repeated more than once and simply using `DISTINCT` is not an option. 

In this case, I will invariably use a CTE to remove the offending repetitions.

### Row Number

This solution will use `int ROW_NUMBER()`, which returns an integer than increments (from 1, by 1) as it traverses the dataset.
It is also a _windowed_ function such that we can partition our dataset along identical values if we so wish.

Suppose we write the following in our `SELECT`: 

```sql
ROW_NUMBER() OVER (PARTITION BY Email ORDER BY Email) AS rn
```
We will get something like:

$$
\begin{array}{|c|c|}
\hline
\text{Email} & \text{rn} \\
\hline
\text{fakeUser@FakeDomain.com} & 1 \\
\text{anotherFake@alsofake.com} & 1 \\
\text{anotherFake@alsofake.com} & 2 \\
\text{notanemail@notReal.com} & 1 \\
\hline
\end{array}
$$

This means we can delete any row where `RN > 1` 
However, function that cannot be used in `WHERE` or `HAVING` clauses.
Therefore we use a CTE:

```sql
WITH cteDedupe AS (
	SELECT
		Email
	,	ROW_NUMER() OVER (PARTITION BY Email ORDER BY NEWID()) AS rn
	FROM dbo.Account
	)
DELETE cteDedupe 
WHERE rn > 1;
```
