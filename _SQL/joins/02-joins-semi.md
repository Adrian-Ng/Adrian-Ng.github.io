---
title: "Joins: Semi"
permalink: /SQL/joins/semi/
excerpt: "A look at the various semi joins in SQL by Adrian Ng"
toc: true
mathjax: true
---

## INTRO

These lack the _syntactic sugar_ of the cartesian joins.
I also find that the syntax of semi-joins tends to more natural human language.

Another big upside is that they are **faster** than cartesian joins because in SQL they avoid the need to compute the cartesian product, which is an expensive operation.


## Relational Algebra

Just a quick note on the algebra for this section. Sometimes you will come across notation for semi join and anti join expressed in terms of the cartesian product. 
Ignore these. 
The way we perform these joins in SQL will not compute anything resembling a cartesian product at all!  

## Relations

$$
R = 
\begin{array}{|c|}
\hline
\alpha \\
\hline
\text{Red} \\
\text{Blue} \\
\text{Yellow} \\ \hline
\end{array}
\qquad
S =
\begin{array}{|c|}
\hline
\beta \\
\hline
\text{Green} \\
\text{Black} \\
\text{Blue} \\ \hline
\end{array}
$$


## SEMI JOIN

In a semi join, we simply check the yes/no response to whether any given tuple in $$R$$ matches to a record in $$S$$.

Unlike a cartesian join, we only return data from $$R$$.  

### SQL

```sql
SELECT
	*
FROM R
WHERE EXISTS (SELECT 1 FROM S WHERE R.alpha = beta)
```


### OUTPUT

$$
\begin{array}{|c|}
\hline
\alpha \\ 
\hline
\text{blue} \\
\hline
\end{array}
$$

### Use Case

* You _only_ want to return columns from $$R$$.
* Data from $$R$$ must match to data in $$S$$

## ANTI JOIN

Use case is same as the semi join except you wish to return the disjoint set.

```sql
SELECT
	*
FROM R
WHERE NOT EXISTS (SELECT 1 FROM S WHERE R.alpha = beta)
```


### OUTPUT

$$
\begin{array}{|c|}
\hline
\alpha \\ 
\hline
\text{Red} \\
\text{Yellow} \\
\hline
\end{array}
$$

## DML

The examples on this page only look at these joins when used with `SELECT`.
But of course, you can use them with other DML operations. 
However, I would advise on being _extra careful_ when running `UPDATE` or `DELETE` against the ouput of a semi or anti join.


