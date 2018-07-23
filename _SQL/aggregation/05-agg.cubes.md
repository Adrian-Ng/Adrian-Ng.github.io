---
title: "Aggregation: Data Cubes"
permalink: /SQL/aggregation/cubes/
excerpt: "Aggregating with Cubes by Adrian Ng"
toc: true
mathjax: true
---

## Intro

Note: to follow along with the examples on this page using the musicDB, you will also need to scroll down to the appendix and follow the steps there.
{: .notice--info}

### Drill Down

So far, we've looked at some simple aggregations involving a single categorical field.

For instance:

```sql
SELECT
	MONTH(dob) 	AS BirthMonth
,	COUNT(*) 	AS Cnt
FROM 	music.Users
GROUP BY 
	MONTH(dob);
```

As you can see, we are looking at _generalised_ view of our customers.

We can __drill down__ to see things at a more _granular_ level by introducing more categorial fields to the `GROUP BY`.

```sql
SELECT
	YEAR(dob) 	AS BirthYear
,	MONTH(dob) 	AS BirthMonth
,	COUNT(*)	AS Cnt
FROM 	music.Users
GROUP BY
	YEAR(dob)
,	MONTH(dob);
```

### Roll Up

Conversely, a __roll up__ is when we move from a _granular view_ to a more _generalised_ view.

In SQL, we can move to a generalised view be adding `WITH ROLLUP`.

```sql
SELECT
	YEAR(dob) 	AS BirthYear
,	MONTH(dob) 	AS BirthMonth
,	DAY(dob)	AS BirthDay
,	COUNT(*)	AS Cnt
FROM 	music.Users
GROUP BY
	YEAR(dob)
,	MONTH(dob)
,	DAY(dob)
WITH ROLLUP;
```

In this way, we can automatically compute the following aggregates:

*	BirthYear, BirthMonth, BirthDay
*	BirthYear, BirthMonth
*	BirthYear

Notice how the fields in the `GROUP BY` are organised in a hierarchical fashion. At the end of each iteration, the lowest field in the hierachy is removed from the `GROUP BY` and the aggregation is computed again.

## Cubes

The hierachical system that `ROLLUP` uses is great - if there is a hierarchy to your categorical fields.

But what if you want to compute your aggregates along all possible subset of _permutations_ of fields contained in `GROUP BY`.

That is we would like to see not only the above combinations, but in addition:

*	BirthYear, BirthDay
*	BirthMonth
*	BirthDay

In this case, we use the `WITH CUBE` modifier instead.

```sql
SELECT
	YEAR(dob) 	AS BirthYear
,	MONTH(dob) 	AS BirthMonth
,	DAY(dob)	AS BirthDay
,	COUNT(*)	AS Cnt
FROM 	music.Users
GROUP BY
	YEAR(dob)
,	MONTH(dob)
,	DAY(dob)
WITH CUBE;
```

## Simulating dob

On this page we simulate `dob` by sampling from the _Normal Distribution_.

Therefore I am making the following assumptions:
* Age has a normal distribution
* ... with a mean of 25
* ... and a standard deviation of 5


### Function

I use this scalar-valued function taken from:

http://www.sqlservercentral.com/articles/SQL+Uniform+Random+Numbers/91103/

```sql
CREATE FUNCTION stats.Normal
    (@Mean FLOAT, @StDev FLOAT, @URN1 FLOAT, @URN2 FLOAT)
 RETURNS FLOAT WITH SCHEMABINDING
AS
BEGIN
    -- Based on the Box-Muller Transform
    RETURN (@StDev * SQRT(-2 * LOG(@URN1))*COS(2*ACOS(-1.)*@URN2)) + @Mean
END

```


### ALTER music.Users

```sql
ALTER TABLE music.Users
ADD dob date;
```

### UPDATE music.Users 


```sql
WHILE (1=1)
BEGIN
	WITH cteSelection AS (
		SELECT TOP 1 
			*
		FROM music.Users
		WHERE dob IS NULL
		ORDER BY NEWID()
		)
	UPDATE cteSelection
	SET		dob = DATEADD(Dd,stats.Normal(25,5, RAND(),RAND())*-356.25,GETDATE())
IF @@ROWCOUNT = 0
BREAK
END
```