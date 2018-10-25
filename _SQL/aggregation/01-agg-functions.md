---
title: "Aggregation: Functions"
permalink: /SQL/aggregation/functions/
excerpt: "Aggregation functions by Adrian Ng"
toc: false
---

## COUNT


How many accounts do we have in music.Account?


```sql
SELECT 
	COUNT(*)
FROM music.Account;
```

How many countries do our users come from?

```sql
SELECT
	COUNT(DISTINCT Country)
FROM	music.Users;
```


## SUM

What's the total listening time of all the songs in our database?

```sql
SELECT
	SUM(duration)
FROM music.Song;
```

Recall the distinction between `SELECT *` and `SELECT 1`

In the former, we return values from every column in the table. 
In the latter, we map 1 to every tuple in the result set.

Furthermore, when we map 1 and reduce using either `SUM(1)` or `COUNT(1)`, we find the two expressions are equivalent.

In fact, `SUM(1)`, `COUNT(1)`, and `COUNT(*)` will return equivalent results - i.e. the number of tuples in each projection.

