---
title: "SQL Basics: SELECT Statements"
permalink: /SQL/Basics-Select/
excerpt: "More ways of writing SELECT statements"
toc: true
---

`SELECT` statements are fundamental: likely the first thing you ever learn or ever type in SQL will be a `SELECT`.
Furthermore, they are incredibly versatile and when used correctly can give us precise control over how we subset our data.

### * vs Column Names

To return all the columns from our table, we simply write

```sql
SELECT
	*
from dbo.Song;
```

But say we don't want to return results from every column.
We are interested in just a subset of columns.
We just explicitly name the columns we need.

```sql
SELECT
	Name
,	Duration
FROM	dbo.Song;
```

### TOP

To return a specific number of rows from `dbo.Song` (say, 3):

```sql
SELECT 
	TOP 3
	*
FROM dbo.Song;
```
ID|Name|Duration
---|---|---
1|Under Pressure|249
2|Billie Jean|293
3|The Winner Takes It All|295

In this example, this is the top 3 based on the physical ordering of the table.
But we can also specify an ordering of our chosing.

### ORDER BY

Let's combine 'TOP' with 'ORDER BY' to get the song with the longest duration.

```sql
SELECT
	TOP 1
	Name
,	Duration
FROM dbo.Song
ORDER BY 
	Duration DESC;
```

Name|Duration
---|---
The Winner Takes It All|295

Note that we don't actually need to use `TOP` in combination with `ORDER BY`. Remove `TOP 3` from the above example and we will return every result from the table.
{: .notice--info}

### WHERE

Suppose we are 

### DISTINCT



