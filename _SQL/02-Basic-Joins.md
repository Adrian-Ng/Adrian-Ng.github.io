---
title: "SQL Basics: Joins"
permalink: /SQL/Basics-Joins/
excerpt: "Some basic stuff with joins"
toc: true
---

Let's not over complicate this!

## JOINS

What is the point of these joins?

## CROSS JOIN 

Also known as the Cartesian Join in _relational algebra_. Here we compose all combination of tuples from the left and right tables.

```sql
SELECT
	*
FROM [leftTable] 
CROSS JOIN [rightTable]
```

Notice that there's no aliasing and no joining fields.
We're not performing matching - we're just composingt tuple combinations between the two tables.K
### INNER JOIN

```sql
SELECT
	*
FROM [leftTable] AS left
INNER JOIN [rightTable] AS right
ON left.ID = right.ID;
```

OR if you prefer the old-fashioned way:

```sql
SELECT
	*
FROM [leftTable] AS left, [rightTable] AS right
WHERE left.ID = right.ID;
```

### LEFT JOIN

```sql
SELECT
	*
FROM [leftTable] AS left
LEFT JOIN [rightTable] AS right
ON left.Id = right.ID;
```

## SEMI-JOINS

These lack the _syntactic sugar_ of the joins above. 
But funnily enough if find that the syntax of semi-joins tends to more natural human language.

Another big upside is that they are **fast**.

There are just two types of semi-joins that I want to show you.

### LEFT SEMI JOIN

Use case:
	* Values in your joining field exist in both tables.
	* You _only_ want to return columns from the left table.
	* Speed is a concern (when isn't it?)

```sql
SELECT
	*
FROM [leftTable] AS left
WHERE EXISTS (SELECT 1 FROM [rightTable] WHERE left.ID = ID)
```

### LEFT ANTI SEMI JOIN

Use case is same as the above except you're returning rows where values in your joining field _don't match_.

```sql
SELECT
	*
FROM [leftTable] AS left
WHERE NOT EXISTS (SELECT 1 FROM [rightTable] WHERE left.ID = ID)
```




