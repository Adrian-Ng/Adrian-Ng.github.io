---
title: "Aggregation: Over Clause"
permalink: /SQL/aggregation/over/
excerpt: "Aggregating with the Over Clause by Adrian Ng"
toc: true
mathjax: true
---

Where do our users come from? 
How do we express the aggregation as a percentage?

## Returning the Count

### SQL 

First, let's write a query that returns the actual figures.

```sql
SELECT
	Country
,	COUNT(*) AS Cnt
FROM music.Users
GROUP BY
	Country;
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

But we have grouped our data by `Country`. If we include this expression in our query, we will get an error:

`Cannot perform an aggregate function on an expression containing an aggregate or a subquery.`
.
To get around this issue, we use something called the __Over Clause__.
This allows us to define the result set as a _window_. 
So instead of performing an aggregation on an expression, we are instead performing an aggregation on each row within the window.

Now we write: `SUM(COUNT(*)) OVER()`

In this case the window is the entire result set returned by the above query. 
As a result, we can sum `Cnt`.

### SQL

```sql
SELECT
	Country
,	COUNT(*) AS Cnt
,	SUM(COUNT(*)) OVER() AS Total
FROM	music.Users
GROUP BY
	Country;
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
	Country;
```

Note: when multiplying or dividing an integer by another integer, our result will also be an integer.
If we expect a non-integer result, we can cast an `int` to `float` by rewriting the integer as a decimal.
This is known as __implicit conversion__.
What is the difference between these two expressions: `SELECT 1/2` and `SELECT 1/2.0`?
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
	Country;
```
