---
title: "Common Table Elements"
permalink: /SQL/cte/
excerpt: "Intro to CTEs"
toc: true
mathjax: true
header:
 image: /assets/images/headers/cte.jpg
---

## The Common Table Element

The Common Table Element (CTE) is essentially a named subquery.

Because they are named, we are able to reference them like a table.
As such they can be used in conjunction with all DML: `SELECT`, `UPDATE`, and `DELETE`.
And of course, they can be used in joins.

Under certain circumstances, they can even be used to reference themselves, recursively.

However, there are some important caveats.
They are more transient than temp tables!
That is, they exist only within the scope of the execution. 

### Pseudocode

The basic pseudocode using `SELECT` is as follows:

```sql
WITH <cteName> AS (
	<subquery goes here>
	)
SELECT
	*
FROM <cteName>;
```

### Scope

You cannot refer to the CTE from a separate query. 
Attempting to run the second query in the example below will return an error.

```sql
WITH cte AS (
	<subquery>
	)
SELECT * FROM cte;

--Separate query
SELECT * FROM cte;
```

### Chaining CTEs

You can use multiple CTEs in a linear fashion for when sequencing is important.
For instance you might be applying a sequence of transformations to your dataset.
Or you might wish to generate a subset _before_ joining for speed. 


```sql
WITH cte1 AS (
	<initial subquery>
	)
,    cte2 AS (
	SELECT * FROM cte1
	)
SELECT * FROM cte2 
```


