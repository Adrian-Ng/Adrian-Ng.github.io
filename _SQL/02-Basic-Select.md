---
title: "SQL Basics: SELECT Statements"
permalink: /SQL/Basics-Select/
excerpt: "More ways of writing SELECT statements"
toc: true
---

These are fundamental and are likely the first thing you ever learn or ever type in SQL.
But, they are incredibly versatile and when used correctly can give us precise control over how we subset our data.

Let's take a look at a few simple ways we can use `SELECT`.

### Column Selection

To return all the columns from our table, we simply write

```sql
SELECT
	*
FROM dbo.Song;
```
ID|Name|Duration
---|---|---
1|Under Pressure|249
2|Billie Jean|293
3|The Winner Takes It All|295
4|Our House|203
5|Take On Me|225
6|The Tide Is High|231
7|Red Red Wine| 182
8|Do You Really Want To Hurt Me|263
9|Relax|238
10|Gold|231


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

This is the top 3 based on the physical ordering of the table.
But we can also specify an ordering of our chosing.

### ORDER BY

Let's combine 'TOP' with 'ORDER BY' to get the song with the longest duration.

```sql
SELECT
	TOP 3
	*
FROM dbo.Song
ORDER BY 
	Duration DESC;
```

ID|Name|Duration
---|---|---
3|The Winner Takes It All|295
2|Billie Jean|293
8|Do You Really Want To Hurt Me|263

Note that we don't actually need to use `TOP` in combination with `ORDER BY`. Remove `TOP 1` from the above example and we will return every result from the table.
{: .notice--info}

### WHERE

When we are only in _specific_ rows of data we use the `WHERE` clause to specify conditions over our selection.

For instance, we are only interested returning _Billie Jean_:

```sql
SELECT
	*
FROM dbo.Songs
WHERE Name = 'Billie Jean';
```
We might be interested in a list of songs.

```sql
SELECT
	*
FROM dbo.Songs
WHERE Name IN ('Billie Jean','Billie Jean');
```

Say we are interested in all songs shorter than 4 minutes. 

```sql
SELECT
	*
FROM dbo.Songs
WHERE Duration < 240;
```

We could even combine multiple `WHERE`clauses with logical operators.
Let's return songs that begin with _T_ and are shorter than 4 minutes.

```sql
SELECT
	*
FROM	dbo.Songs
WHERE Duration < 240
AND Name LIKE 'T%';
```

`%` is a wildcard and is used to substitute **any number** of characters (including zero).
`_` is also a wildcard and is used to substitute **a single** character.
{: .notice--info}







