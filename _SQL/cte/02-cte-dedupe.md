---
title: "CTEs: Deduping"
permalink: /SQL/cte/dedupe/
excerpt: "Using Common Table Elements to remove duplicates in SQL by Adrian Ng"
toc: False
---

## ROW NUMBER


This involves using `ROW_NUMBER()`.
This function that cannot be used in `WHERE` or `HAVING` clauses.



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
