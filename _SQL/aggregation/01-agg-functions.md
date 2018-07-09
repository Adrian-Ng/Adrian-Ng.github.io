---
title: "Aggregation: Functions"
permalink: /SQL/aggregation/functions/
excerpt: "Aggregation functions by Adrian Ng"
toc: false
---


## Intro

Let's take look at some aggregation functions!

Such as these...

* COUNT()
* SUM()


## COUNT



### *

How many accounts do we have in music.Account?


```sql
SELECT 
	COUNT(*)
FROM music.Account;
```

### Distinct

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




Do you recall the distinction between `SELECT *` and `SELECT 1`?

In the former, we return values from every column in the table. 
In the latter, we express 1 in a single column for every row in the result set.

We can use both these functions to 

