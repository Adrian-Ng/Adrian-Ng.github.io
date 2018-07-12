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

### SQL 1

First, let's write a query that returns the actual figures.

```sql
SELECT
	Country
,	COUNT(*) AS Cnt
FROM music.Users
GROUP BY
	Country;
```

### Output 1

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

To compute the percentage, we need to divide each value of Cnt by the total number of users in the table.
The total is the sum of every value in `Cnt`.
That is: `SUM(COUNT(*))`.

But we have grouped our data by `Country`.

We can use something called the __Over Clause__ to perform an aggregation _over_ a window.

That is: `SUM(COUNT(*)) OVER()`

In this case the window is the entire result set returned by the above query. 
In other words, our windowing overrides the partitioning dictated by the `GROUP BY`.
As a result, we can return the total number of users in the table.

## Computing the Total

### SQL 2

```sql
SELECT
	Country
,	COUNT(*) AS Cnt
,	SUM(COUNT(*)) OVER() AS Total
FROM	music.Users
GROUP BY
	Country;
```

### Output 2

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

### SQL 3

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
If we expect a non-integer result, we can an integer to a float by rewriting it as a decimal.
This is known as __implicit conversion__.
Try the following expressions:
`SELECT 1/2`
`SELECT 1/2.0`
{: .notice--info}



### Output 3

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
\text{Poland} & 4 & 100 4.000000000000 \\
\hline
\cdots & \cdots & \cdots & \cdots \\
\hline
\end{array}
$$
