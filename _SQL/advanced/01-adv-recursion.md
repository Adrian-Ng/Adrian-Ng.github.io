---
title: "SQL Advanced: Recursion"
permalink: /SQL/Advanced/Recursion/
excerpt: "Recursion in SQL"
#toc: true
classes: wide
---

Recursion is possible in SQL via the use of a type of subquery known as a Common Table Element (CTE).
One handy feature of CTEs is that they have names which makes it easy for us to reference these subqueries when we want.
We can write CTEs such that we reference the CTE from _within_ the CTE. 

That is, we write a CTE that applies some transformation to some input recursively until some stopping condition is met.

One general area where I find recursion to be particularly useful in SQL is regex. 
For example, suppose we have a string of pipe separated data: Eggs|Milk|Juice|Bread

Let's write a SQL query that can separate this string to a column of values.

```sql
DECLARE @str varchar(100)
SET @str = 'Eggs|Milk|Juice|Bread|';

WITH cteRecursion AS (
	SELECT
		SUBSTRING(@str,0,CHARINDEX('|',@str,1)) AS output
	,	SUBSTRING(@str,CHARINDEX('|',@str,1) + 1, LEN(@str)) as remainder
	UNION ALL SELECT
		SUBSTRING(remainder,0,CHARINDEX('|',remainder,1))
	,	SUBSTRING(remainder,CHARINDEX('|',remainder,1) + 1, LEN(remainder))
	FROM cteRecursion
	WHERE CHARINDEX('|', remainder,1) <> 0
	)
SELECT 
	output
FROM cteRecursion;	

```

|output|
|---|
|Eggs|
|Milk|
|Juice|
|Bread|

