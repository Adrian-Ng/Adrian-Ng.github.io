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

However, it is not uncommon to see these used improperly. This page will advise on and against the various use cases of __cartesian joins__.

## Relations

For each of our examples on this page, we will consider the following two relations: $$R$$ and $$S$$:

$$
R =
\begin{array}{|c|}
\hline
\alpha \\ \hline
A\\
B\\
C\\ \hline
\end{array}
\qquad
S =
\begin{array}{|c|c|c|c|}
\hline
\beta \\ \hline
C\\ 
C\\ 
D\\ \hline
\end{array}
$$


## CROSS JOIN

In SQL, we use `CROSS JOIN` to compute the cartesian product of two relations.
That is, we compute all possible __combinations__ of tuples.

### Relational Algebra

We can mathematically represent the cartesian product of two relations as follows:

$$
\sigma (R \times S)
$$ 

Where $$\times$$ represents the cartesian product.

### SQL

To use `CROSS JOIN` in SQL, we would write something like the following:

```sql
SELECT
	*
FROM R
CROSS JOIN S
```
Note that unlike `INNER JOIN`, we aren't matching on anything. 

### Output

$$
\sigma (R\times S) = 
\begin{array}{|c|c|}
\hline
\alpha & \beta \\ \hline
A & C \\ 
B & C \\ 
C & C \\
A & C \\ 
B & C \\ 
C & C \\ 
A & D \\ 
B & D \\  
C & D \\ \hline
\end{array} 
$$

As you can see, our SQL query has returned $$3 \times 3 = 9 $$ tuples.
The result-set of a cartesian product will always be of length $$M \times N$$, where $$M$$ and $$N$$ represent the respective lengths of the two relations.

## INNER JOIN

### Relational Algebra

In relational algebra, we represent an `INNER JOIN` as follows:

$$
\sigma_{\alpha = \beta} (R\times S)
$$

In other words, we _again_ compute a cartesian product but return __only__ the tuples that match on the joining fields.

### SQL

The syntax for `INNER JOIN` in SQL resembles something like this:

```sql
SELECT 
	alpha
,	beta
FROM R
INNER JOIN S
ON R.alpha = S.beta
```

### Output

$$
\sigma_{\alpha = \beta} (R\times S) = 
\begin{array}{|c|c|}
\hline
\alpha & \beta \\ \hline 
C & C \\ 
C & C \\ \hline
\end{array} 
$$

In this case we have returned just the one tuple. But `INNER JOIN` can return any number of tuples in the range $$0 <= M\times N$$. It just depends on the number of matching tuples. 

## LEFT JOIN

### Relational Algebra

$$
\sigma_{\alpha = \beta}(R\times S) \cup ((R - \Pi_{r_1,...r_n}(\sigma_{\alpha = \beta} (R \times S))) \times S_{NULL})
$$

Let's break this down.

$$
\begin{array}{|c|c|}
\hline
\sigma_{\alpha = \beta}(R \times S) & \text{inner join} \\
((R_1 - \Pi_{r_1,...,r_n}(\sigma_{\alpha = \beta} (R \times S))) & \text{left anti semi join} \\
S_{NULL} & n\text{-tuple. NULL for each attribute in } S \\
\hline
\end{array}
$$

So it is more or less accurate to state that a Left Join is the union between an __inner join__ and a __left anti semi join__.

### SQL

As such, we could write our SQL like this to return the product of a left join:

```sql
WITH cteInner AS (
	SELECT
		*
	FROM R 
	INNER JOIN S
	ON R.alpha = S.beta
	)
SELECT
	*
FROM cteInner
UNION ALL
SELECT
	*
FROM R.alpha AS X
CROSS JOIN (SELECT NULL AS omega) AS o
WHERE NOT EXISTS 
(	SELECT 1 
	FROM cteInner  
	WHERE X.alpha = alpha);
```

But with some syntactic sugar, we need only write:

```sql
SELECT 
 *
FROM R
LEFT JOIN S
ON R.alpha = S.beta
```

### Output

$$ 
\begin{array}{|c|c|}
\hline
\alpha & \beta \\ \hline 
A & NULL \\
B & NULL \\
C & C \\
C & C \\
\hline
\end{array} 
$$

