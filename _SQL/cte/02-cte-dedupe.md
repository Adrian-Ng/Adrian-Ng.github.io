---
title: "CTEs: Deduping"
permalink: /SQL/cte-dedupe/
excerpt: "Using Common Table Elements to remove duplicates in SQL by Adrian Ng"
toc: true
---

## Example 1

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
