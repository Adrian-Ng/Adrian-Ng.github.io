---
title: "SQL Basics: SELECT Statements"
permalink: /SQL/Basics-Select/
excerpt: "More ways of writing SELECT statements"
toc: true
---

We looked at an example of SELECT statments here (link to be inserted later). But now lets look in further detail.

### TOP

```sql
SELECT 
	TOP 3
	*
FROM dbo.Songs;
```

ID|Name|Duration
---|---|---
1|Under Pressure|249
2|Billie Jean|293
3|The Winner Takes It All|295

### ORDER BY

Let's combine TOP with an ORDER By to get the song with the longest duration.

```sql
SELECT
	TOP 1
	Name
,	Duration
FROM dbo.Songs
ORDER BY 
	Duration DESC;
```

Name|Duration
---|---
The Winner Takes It All|295

We can also use LEN(), which returns the _length_ of a string to see which song has the shortest name:

```sql
SELECT
	TOP 1
	Name
,	LEN(Name) AS numChar
FROM dbo.Songs
ORDER BY 
	LEN(Name) ASC;
```

Name|numChar
---|---
Our House|9

### WHERE



### DISTINCT



