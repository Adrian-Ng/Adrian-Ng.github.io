---
title: "Aggregation: Over Clause"
permalink: /SQL/aggregation/over/
excerpt: "Aggregating with the Over Clause by Adrian Ng"
toc: true
mathjax: true
---

## Intro to Over

On previous pages we looked at the utilisation of a single aggregation function in a `SELECT` statement.
Suppose we'd like to wrap an aggregation function around another aggregation function like so: `SELECT SUM(COUNT(*))`.
In SQL, this is unfortunately __forbidden__. 

We _could_ instead rely on subqueries (CTEs in particular) to get around this limitation.

However, there are some instances where we need not result to such verbosity.
We now introduce the `OVER()` clause, which makes such expressions possible in a single statement.

## Questions

First, let's assume we need to answer the following questions:

* Where do our users come from? 
* How do we express the aggregation as a percentage?

## Returning the Count

### SQL 

First, let's write a query that returns the actual figures.

```sql
SELECT
	Country
,	COUNT(*) AS Cnt
FROM music.Users
GROUP BY
	Country
ORDER BY 
	COUNT(*) DESC;
```

### Output 

$$
\begin{array}{|c|c|}
\hline
\text{Country} & \text{Cnt} \\ 
\hline
\text{United States} & 26 \\
\hline
\text{France} & 9 \\
\hline
\text{Russia} & 7 \\
\hline
\text{Poland} & 4 \\
\hline
\cdots & \cdots \\
\hline
\end{array}
$$

## Computing the Total

To compute the percentage, we first need to get the total number of users in `music.Users`.
We can augment that above query such that the total is the sum of every value in `Cnt`.
That is: `SUM(COUNT(*))`.

If we include this expression in our query, we will get an error:

`Cannot perform an aggregate function on an expression containing an aggregate or a subquery.`

That is, we cannot use an aggregate function on another aggregate function. 
Why? It kind of boils dwon to a _sequencing_ issue. 

To rephrase the problem, we want to sum all the values of `Cnt` in the output above.
Therefore, We need to explicitly tell SQL that we need to use `SUM()` _only_ once the above result set has been computed.

We can do this with `OVER()`.
This allows us to define the result set as a _window_. 
So instead of aggregating on an aggregate, we aggregate on the _result set_ via a window which interposes itself between the two aggregations.

Now we write: `SUM(COUNT(*)) OVER()`

In this case the window is the entire result set returned by the above query.
This is because have not specified any _partitioning_. 
We are summming all values of `Cnt`.

### SQL

```sql
SELECT
	Country
,	COUNT(*) AS Cnt
,	SUM(COUNT(*)) OVER() AS Total
FROM	music.Users
GROUP BY
	Country
ORDER BY 
	COUNT(*) DESC;
```

### Output

$$
\begin{array}{|c|c|c|}
\hline
\text{Country} & \text{Cnt} & \text{Total} \\ 
\hline
\text{United States} & 26 & 100 \\
\hline
\text{France} & 9 & 100 \\
\hline
\text{Russia} & 7 & 100 \\
\hline
\text{Poland} & 4 & 100 \\
\hline
\cdots & \cdots & \cdots \\
\hline
\end{array}
$$

Note: `Cnt` in the output table does not sum to 100 as I'm not displaying every row in the result set.
{: .notice--info}


## Expressing the Percentage

Now we can simply write an expression that divides `Cnt` by `Total` and multiplies by 100.0 to get the percentage.

### SQL

```sql
SELECT
	Country
,	COUNT(*) AS Cnt
,	SUM(COUNT(*)) OVER() AS Total
,	COUNT(*)*100.0/SUM(COUNT(*)) OVER() AS Pcnt
FROM	music.Users;
GROUP BY
	Country
ORDER BY
	COUNT(*) DESC;
```

Note: when multiplying or dividing an integer by another integer, our result will also be an integer.
If we expect a non-integer result, we can cast an `int` to `float` by rewriting the integer as a decimal.
This is known as __implicit conversion__.
To illustrate this, compare these two expressions: `SELECT 1/2` and `SELECT 1/2.0`.
{: .notice--info}

### Output

$$
\begin{array}{|c|c|c|c|}
\hline
\text{Country} & \text{Cnt} & \text{Total} & \text{Pcnt }\\ 
\hline
\text{United States} & 26 & 100 & 26.000000000000\\
\hline
\text{France} & 9 & 100 & 9.000000000000 \\
\hline
\text{Russia} & 7 & 100 & 7.000000000000 \\
\hline
\text{Poland} & 4 & 100 & 4.000000000000 \\
\hline
\cdots & \cdots & \cdots & \cdots \\
\hline
\end{array}
$$


Voila! We have computed the percentage distribution of an aggregation in SQL using a single query.
We could have used a subquery to return the total, but that would have been verbose.

## Subquery Example

```sql
WITH cteTotal AS (
	SELECT
		COUNT(*) AS Total
	FROM 	music.Users;
	)
SELECT
	Country
,	COUNT(*)*100.0/(SELECT Total FROM cteTotal)
FROM	music.Users
GROUP BY 
	Country
ORDER BY COUNT(*) DESC;
```
