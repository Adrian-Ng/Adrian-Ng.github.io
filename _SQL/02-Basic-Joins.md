---
title: "SQL Basics: Joins"
permalink: /SQL/Basics-Joins/
excerpt: "Some basic stuff with joins"
toc: true
---

Let's not over complicate this!

## JOINS

Whatt are the point of these joins?

### INNER JOIN

```sql
SELECT
*
FROM [leftTable] AS left
INNER JOIN [rightTable] AS right
ON left.ID = right.ID;
```

OR

```sql
SELECT
	*
FROM [leftTable] AS left, [rightTable] AS right
WHERE left.ID = right.ID;
```

### LEFT JOIN


## SEMI-JOINS

These lack the _syntactic sugar_ of the joins above. 
But funnily enough if find that the syntax of semi-joins is more self explanatory.

### LEFT SEMI JOIN

When you want to return a subset of data consisting only of tuples and columns from the left table but must also match to the right table on some joining field.

```sql
SELECT
	*
FROM [leftTable] AS left
WHERE EXISTS (SELECT 1 FROM [rightTable] WHERE left.ID = ID)
```

### LEFT ANTI SEMI JOIN

When you want to return a subset of data from the left table that does not match to the right table.

```sql
SELECT
	*
FROM [leftTable] AS left
WHERE NOT EXISTS (SELECT 1 FROM [rightTable] WHERE left.ID = ID)
```

## CROSS JOIN 

Also known as the Cartesian Join in _relational algebra_. Here we compose all combination of tuples from the left and right tables.


