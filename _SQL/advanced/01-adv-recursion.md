---
title: "SQL Advanced: Recursion"
permalink: /SQL/Advanced/Recursion/
excerpt: "Recursion in SQL"
#toc: true
classes: wide
---

Recursion is possible in SQL via the use of a type of subquery known as a Common Table Element (CTE).
One handy feature of CTEs is that they have names which makes it easy for us to reference these subqueries when we want.

Furthermore, we can write CTEs such that we reference the CTE from _within_ the CTE. 
That is, we write a CTE that applies some transformation to some input recursively until some __stopping condition__ is met.

One general area where I find recursion to be particularly useful in SQL is regex. 
For example, suppose we have a string of comma-separated values:

```sql
DECLARE @str = 'Eggs,Milk,Juice,Bread,';
```

## Anchor Member

Now, let's write a SQL query that can separate this string to a column of values.
A recursive subquery is written in two parts. First we write the __anchor__. 
This is the output on the first iteration.

```sql
SELECT
	SUBSTRING(@str,0,CHARINDEX(',',@str,1)) AS output
,	SUBSTRING(@str,CHARINDEX(',',@str,1) + 1, LEN(@str)) AS remainder
```
|output|remainder|
|---|---|
|Eggs|Milk|

We've split our string into two parts: `output` and `remainder`, which is to be split further in the recursive part.

## Recursive Part

The __recursive__ part is identical to our transformation in the Anchor but has `remainder` as the input.
Here we invoke the CTE and include a stopping condition, which stops the recursion when `remainder` contains no more commas.

```sql
WITH cteRecursion AS (
	SELECT  -- anchor members
		SUBSTRING(@str,0,CHARINDEX(',',@str,1)) AS output
	,	SUBSTRING(@str,CHARINDEX(',',@str,1) + 1, LEN(@str)) as remainder
	UNION ALL SELECT -- recursive members
		SUBSTRING(remainder,0,CHARINDEX(',',remainder,1))
	,	SUBSTRING(remainder,CHARINDEX(',',remainder,1) + 1, LEN(remainder))
	FROM cteRecursion -- invoke CTE
	WHERE CHARINDEX(',', remainder,1) <> 0 -- stopping condition
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

