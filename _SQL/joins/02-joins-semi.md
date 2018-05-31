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

### Use Case

* Values in your joining field exist in both tables.
* You _only_ want to return columns from $$R$$.
* Speed is a concern (when isn't it?)

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

## ANTI JOIN

Use case is same as the above except you're returning rows where values in your joining field _don't match_.

```sql
SELECT
	*
FROM [leftTable] AS left
WHERE NOT EXISTS (SELECT 1 FROM [rightTable] WHERE left.ID = ID)
```

