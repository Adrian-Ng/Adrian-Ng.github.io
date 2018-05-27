---
title: "Joins: Cartesian"
permalink: /SQL/joins/cartesian/
excerpt: "A look at the various cartesian joins in SQL by Adrian Ng"
toc: true
mathjax: true
---

$$
\def\ojoin{\setbox0=\hbox{$\Join$}%
  \rule[-.02ex]{.25em}{.4pt}\llap{\rule[1.10ex]{.25em}{.4pt}}}
\def\leftouterjoin{\mathbin{\ojoin\mkern-8.5mu\Join}}
\def\rightouterjoin{\mathbin{\Join\mkern-8.5mu\ojoin}}
\def\fullouterjoin{\mathbin{\ojoin\mkern-8.5mu\Join\mkern-8.5mu\ojoin}}
$$


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

In SQL, we use `CROSS JOIN` to compute the cartesian product of two relations.
That is, we compute all possible __combinations__ of tuples.

### Relational Algebra

We can mathematically represent the cartesian product of two relations as follows:

$$
\sigma (R_1 \times R_2)
$$ 

Where $$\times$$ represents the cartesian product.

### SQL

To use `CROSS JOIN` in SQL, we would write something like the following:

```sql
SELECT
	*
FROM R1
CROSS JOIN R2
```
Note that unlike `INNER JOIN`, we aren't matching on anything. 

### Output

$$
\sigma (R_1\times R_2) = 
\begin{array}{|c|c|}
\hline
\alpha & \beta \\ \hline
A & C \\ 
B & C \\ 
C & C \\ 
A & D \\ 
B & D \\  
C & D \\ \hline
\end{array} 
$$

As you can see, our SQL query has returned $$3 \times 2 $$ tuples.
The result-set of a cartesian product will always be of deterministic length $$M \times N$$ where $$M$$ and $$N$$ represent the respective lengths of the two relations.

## INNER JOIN

### Relational Algebra

In relational algebra, we represent an `INNER JOIN` as follows:

$$
\sigma_{\alpha = \beta} (T_2 \times T_2)
$$

In other words, we _again_ compute a cartesian product and return __only__ the tuples that match on the joining fields.

### SQL

The syntax for `INNER JOIN` in SQL resembles something like this:

```sql
SELECT 
	alpha
,	beta
FROM R1
INNER JOIN R2
ON R1.alpha = R2.beta
```

### Output

$$
\sigma_{\alpha = \beta} (R_1\times R_2) = 
\begin{array}{|c|c|}
\hline
\alpha & \beta \\ \hline 
C & C \\ \hline
\end{array} 
$$

In this case we have returned just the one tuple. But `INNER JOIN` can return any number of tuples in the range $$0 <= M\times N$$. It just depends on the number of matching tuples. 

## LEFT JOIN

### Relational Algebra

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


$$
\leftouterjoin
\sigma_{(\alpha = \beta)|| \beta = NULL} (R_1\times R_2) = 
\begin{array}{|c|c|}
\hline
\alpha & \beta \\ \hline 
A & NULL \\ \hline
B
\end{array} 
$$

