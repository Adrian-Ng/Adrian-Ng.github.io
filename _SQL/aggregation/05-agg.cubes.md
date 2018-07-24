---
title: "Aggregation: Data Cubes"
permalink: /SQL/aggregation/cubes/
excerpt: "Aggregating with Cubes by Adrian Ng"
toc: true
classes: wide
mathjax: true
---

$$
\pgfmathdeclarefunction{gauss}{2}{%\pgfmathparse{1/(#2*sqrt(2*pi))*exp(-((x-#1)^2)/(2*#2^2))}%
$$

## Intro

Note: to follow along with the examples on this page using the musicDB, you will also need to scroll down to [simulating dob](/SQL/aggregation/cubes/#simulating-dob) and following the steps there.
{: .notice--info}

### Drill Down

So far, we've looked at some simple aggregations involving a single categorical field.

For instance:

```sql
SELECT
	YEAR(dob) 	AS BirthYear
,	COUNT(*) 	AS Cnt
FROM 	music.Users
GROUP BY 
	YEAR(dob);
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

In SQL, we can do this by adding `WITH ROLLUP`.

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

In this way, we can automatically perform the aggregation with each of these combinations of fields in the `GROUP BY`.:

*	BirthYear, BirthMonth, BirthDay
*	BirthYear, BirthMonth
*	BirthYear

That is, instead of writing three different SQL statements, we need only write _one_.

Notice how these fields are organised in a hierarchical fashion. 
At the end of each iteration, the lowest field in the hierachy is removed from the `GROUP BY` and the aggregation is computed again.

## Cubes

But what if you want to compute your aggregates along all possible subset of _permutations_ of fields contained in `GROUP BY`?

We would like to see not only the above combinations, but in addition:

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

On this page we simulate `dob` by sampling from the __Normal Distribution__ $$\phi \sim N(\mu,\sigma)$$.

Where:
* $$\mu = 25$$
* $$\sigma = 5$$

### Function

To sample from the Normal Distribution, we use a scalar-valued function taken from [here](http://www.sqlservercentral.com/articles/SQL+Uniform+Random+Numbers/91103/).

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

To invoke it:
```sql 
SELECT stats.Normal(25,5,RAND(),RAND())
```
where `RAND()` samples from the __standard uniform distribution__ $$U(0,1)$$

### ALTER music.Users

Our function `stats.Normal` is designed to sample a person's age at random. In a real database, we would not record someone's age but instead their date of birth.

So let's write some DDL to add `dob` to `music.Users`.

```sql
ALTER TABLE music.Users
ADD dob date;
```

Assuming the function returns our users _present_ age, then we can use `DATEADD()` to accurately estimate their age.

```sql
dob = DATEADD(Dd,stats.Normal(25,5, RAND(),RAND())*-356.25,GETDATE())
``` 

### UPDATE music.Users 

Let's update each row in `music.Users` with a random birth date using our new function `stats.Normal`.

Now because the function is neither a table-valued or windowed type, we need to invoke it once for each row in the table.

Otherwise, we will return the same `age` for each row.

Try the following to see for yourself:

```sql
SELECT 
	stats.Normal(25,5, RAND(),RAND()) AS age
FROM music.Users
```

The solution is to iterate through a `WHILE` loop.
At each iteration, we select a random singleton tuple and invoke `stats.Normal`. 
This is done in entirely in a subquery.
The superquery is an `UPDATE` statement in which `age` is expressed as `dob`.

The while loop ends after the first iteration where `@@ROWCOUNT = 0`. 
That is, when we have run out of rows to update. 

```sql
WHILE (1=1)
BEGIN
	WITH cteSelection AS (
		SELECT TOP 1 
			dob
		,	stats.Normal(25,5, RAND(),RAND()) AS age
		FROM music.Users
		WHERE dob IS NULL
		ORDER BY NEWID()
		)
	UPDATE cteSelection
	SET		dob = DATEADD(Dd,age*-356.25,GETDATE())
IF @@ROWCOUNT = 0
BREAK
END
```
You may notice that this is not a set-based solution.
This is because of the scalar-valued function.
A table-valued function would make for neater syntax.
Note to self: re-write this page to make use of table-valued function.
{: .notice--info}