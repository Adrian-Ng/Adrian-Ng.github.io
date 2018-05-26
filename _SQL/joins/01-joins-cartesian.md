---
title: "Joins: Cartesian"
permalink: /SQL/joins/cartesian/
excerpt: "A look at the various cartesian joins in SQL by Adrian Ng"
toc: true
mathjax: true
---

## Intro

When joining two relations via use of, say, `CROSS`, `INNER`, or `LEFT` joins, it is very important to understand the ramifications of such an undertaking. 
These kind of join are powerful and easy to implement due to their friendly _syntactic sugar_ and are used all the time by SQL professionals to great effect. 

However, it is not uncommon to see these wielded improperly. This page will advise on and against the various use cases of __cartesian joins__.

## Relations

For each of our examples on this page, we will consider the following two relations: $$R_1$$ and $$R_2$$:

$$
R_1 =
\begin{array}{|c|}
\hline
\alpha \\ \hline
A\\
B\\
C\\ \hline
\end{array}
\qquad
R_2 =
\begin{array}{|c|c|c|c|}
\hline
\beta \\ \hline
C\\ \hline
D\\ \hline
\end{array}
$$


## CROSS JOIN

### Relational Algebra

### SQL

```sql
SELECT
	*
FROM table1
CROSS JOIN table2
```

This computes all possible combination of tuples and will return a set of size 3x2.
This is also known as a  __cartesian join__ or __cartesian product__.

### Output

$$
R_1\times\R_2 = 
\begin{array}{|c|c|}
\hline
\alpha $ \beta \\ \hline
A $ C \\ \hline
B $ C \\ \hline
C $ C \\ \hline
A $ D \\ \hline
B $ D \\ \hline 
C $ D \\ \hline 
$$





## INNER JOIN

```sql
SELECT 
	 *
FROM table1 AS t1
INNER JOIN table2 AS t2
ON t1.LettersAE = t2.LettersCD
```

This computes a cartesian join and returns _only_ the tuples that match on the __joining fields__.

|LettersAE|LettersCD|
|---|---|
|C|C|

## LEFT JOIN

```sql
SELECT 
 *
FROM table1 AS t1
LEFT JOIN table2 AS t2
ON t1.LettersAE = t2.LettersCD
```

This is similar to an `INNER JOIN` but relaxes the condition that the joining fields must _always_ match.

In addition to returning matching tuples, it returns tuples from the left table that don't match to anything in the right table.

The result set will have the same number of tuples as the left table.

|LettersAE|LettersCD|
|---|---|
|A|NULL|
|B|NULL|
|C|C|



