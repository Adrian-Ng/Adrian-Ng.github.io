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

But suppose we don't want to return results from every column.
We are only interested in a subset of columns.
So we explicitly name the columns we need.

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
Note: the opposite of `=` is `<>` _or_ `!=` but I think the latter is deprecated.
{: .notice--info}

We might be interested in a list of songs:

```sql
SELECT
	*
FROM dbo.Songs
WHERE Name IN ('Billie Jean','Billie Jean');
```
{%  capture notice-text %}
* The opposite of `IN` is `NOT IN`
* If you have _very large_ list of songs use a **left semi join** or **anti left semi join** instead of `WHERE`.
{% endcapture %}

<div class="notice--info">
  <h4>Note:</h4> 
  {{ notice-text | markdownify }} 
</div>

Say we are interested in all songs beginning with the letter **T**.

```sql
SELECT
	*
FROM dbo.Songs
WHERE Name LIKE 'T%';
```

{% capture notice-text %}
* `%` is a wildcard and is used to substitute **any number** of characters (including zero).
* `_` is also a wildcard and is used to substitute **a single** character.
{% endcapture %}

<div class="notice--info">
  <h4>Note:</h4> 
  {{ notice-text | markdownify }} 
</div>

Say we are interested in all songs shorter than 4 minutes.

```sql SELECT
	*
FROM dbo.Songs
WHERE Duration < 240;
```

We could even accommodate multiple conditions with  logical operators (`AND`,`OR`).
Let's return songs that begin are shorter than 4 minutes but also longer than (or equal to) 3 minutes.

```sql
SELECT
	*
FROM	dbo.Songs
WHERE Duration < 240
AND Duration >= 210;
```

Note: I'm not a fan of using `BETWEEN` (look it up). Your mileage may vary but I like how there is no ambiguity between `>` and `>=` or `<` and `<=`.
{: .notice--info}










