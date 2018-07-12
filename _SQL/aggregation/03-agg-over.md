---
title: "Aggregation: Over Clause"
permalink: /SQL/aggregation/over/
excerpt: "Aggregating with the Over Clause by Adrian Ng"
toc: false
---

Where do our users come from? How do we express the aggregation as a percentage?

First, let's write a query that returns the actual figures.

```sql
SELECT
	Country
,	COUNT(*) AS Cnt
FROM music.Users
GROUP BY
	Country;
```
To compute the percentage, we need to divide each value of `Cnt` by the total number of users in the table.
The total is the sum of every value in `Cnt`.
That is: `SUM(COUNT(*))`.

But we have grouped our data by Country.

We can use something called the __Over Clause__ to perform an aggregation _over_ a window.
In this case the window is the entire result set returned by the above query. 
In other words, our window has no partitioning.

```sql
SELECT
	Country
,	COUNT(*) AS Cnt
,	SUM(COUNT(*)) OVER() AS Total
FROM	music.Users
GROUP BY
	Country;
```






```sql
SELECT
	Country
,	COUNT(*) AS Cnt
,	COUNT(*)*100.0/SUM(COUNT(*)) OVER() AS Pcnt
FROM	music.Users;
GROUP BY
	Country;
```
