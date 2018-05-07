---
title: "Joins: Cartesian"
permalink: /SQL/joins/cartesian/
excerpt: "A look at the various cartesian joins in SQL by Adrian Ng"
toc: true
---

Consider `table1`:

|Letters1|
|---|
|A|
|B|
|C|

and `table2`:

|Letters2|
|---|
|C|
|D|

## CROSS JOIN

```sql
SELECT
	*
FROM table1
CROSS JOIN table2
```

This computes all possible combination of tuples and will return a set of size 3x2
This is also known as a  __cartesian join__.

|Letters1|Letters2|
|---|---|
|A|C|
|B|C|
|C|C|
|A|D|
|B|D|
|C|D|


## INNER JOIN

```sql
SELECT 
	 *
FROM table1 AS t1
INNER JOIN table2 AS t2
ON t1.Letters1 = t2.Letters2
```

This computes a cartesian join and returns _only_ the tuples that match on the __joining fields__.

|Letters1|Letters2|
|---|---|
|C|C|

## LEFT JOIN

```sql
SELECT 
 *
FROM table1 AS t1
LEFT JOIN table2 AS t2
ON t1.Letters1 = t2.Letters2
```

This is similar to an `INNER JOIN` but relaxes the condition that the joining fields must _always_ match.

In addition to returning matching tuples, it returns tuples from the left table that don't match to anything in the right table.

The result set will have the same number of tuples as the left table.

|Letters1|Letters2|
|---|---|
|A|NULL|
|B|NULL|
|C|C|



