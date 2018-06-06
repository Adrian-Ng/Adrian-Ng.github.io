---
title: "CTEs: Recursion"
permalink: /SQL/cte/recursion/
excerpt: "Recursive CTEs in SQL"
toc: true
classes: wide
mathjax: True
---

Recursion is possible in SQL via the use of a type of subquery known as a Common Table Element (CTE).
One handy feature of CTEs is that they have names which makes it easy for us to reference these subqueries when we want.
Let's name our cte `cteRecursion`.

Now, we can invoke `cteRecursion` from _within_ `cteRecursion`. 
That is, we write a CTE that applies some transformation to some input recursively until some __stopping condition__ is met.

## Pseudocode

```sql
WITH cteRecursion AS (
	SELECT 
		anchorMembers
	UNION ALL SELECT 
		recursiveMembers
	FROM cteRecursion
	)
SELECT * FROM cteRecursion;
```
As you can see, the CTE contains a union between so-called __anchor members__ and __recursive members__.

## Handling Regex

One general area where I find recursion to be particularly useful in SQL is regex. 
For example, suppose we have a string of comma-separated values:

```sql
DECLARE @str = 'Eggs,Milk,Juice,Bread,';
```

## Anchor

Now, let's write a SQL query that can separate this string to a column of values.
First we write the transformation for our anchor members `output` and `remainder`.
These anchor transformations define what happens in our recursion on the first iteration.

### SQL

```sql
SELECT
	SUBSTRING(@str,0,CHARINDEX(',',@str,1)) AS output
,	SUBSTRING(@str,CHARINDEX(',',@str,1) + 1, LEN(@str)) AS remainder
```

### Output


$$ 
\begin{array}{|c|c|}
\hline 
\text{output} & \text{remainder} \\
\hline
\text{eggs} & \text{Milk,Juice,Bread} \\
\hline
\end{array}
$$

We've split our string into two parts: `output` and `remainder`. 
Now we recurse through the latter on subsequent iterations.

## Recursion

The transformations for the recursive members are identical to the transformations for the anchor members.
But now we invoke `cteRecursion` and include a stopping condition, which stops the recursion when `remainder` contains no more commas.

### SQL

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

### Final Output

So after some number of iterations, we return the following:

$$
\begin{array}{|c|}
\hline
\text{output} \\
\hline
\text{Eggs} \\
\text{Milk} \\
\text{Juice} \\
\text{Bread} \\
\hline
\end{array}
$$


