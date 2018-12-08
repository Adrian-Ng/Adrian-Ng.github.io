---
title: "Aggregation: Data Cubes"
permalink: /SQL/aggregation/cubes/
excerpt: "Aggregating with Cubes by Adrian Ng"
toc: true
classes: wide
mathjax: true
header:
 image: /assets/images/headers/aggregation.jpg
---

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

```
BirthYear   Cnt
----------- -----------
1981        1
1983        1
1984        3
1985        4
1986        3
1988        1
1989        5
1990        2
1991        7
1992        14
1993        10
1994        6
1995        9
1996        5
1997        12
1998        4
1999        2
2000        5
2001        2
2002        3
2003        1
```

But what if we want more detail?
We can __drill down__ to see things at a more _granular_ level by introducing more categorial fields to the `GROUP BY`.

```sql
SELECT
	TOP 20
	YEAR(dob) 	AS BirthYear
,	MONTH(dob) 	AS BirthMonth
,	COUNT(*)	AS Cnt
FROM 	music.Users
GROUP BY
	YEAR(dob)
,	MONTH(dob);
```
Now we aggregate by __year__ and __month__. We can see that we have one user born in January 1989.

```
BirthYear   BirthMonth  Cnt
----------- ----------- -----------
1989        1           1
1992        1           3
1993        1           3
1995        1           1
1996        1           1
1997        1           2
1999        1           1
2002        1           1
1985        2           1
1991        2           1
1992        2           3
1993        2           1
1994        2           1
1995        2           2
1997        2           1
1991        3           1
1992        3           2
1993        3           1
1994        3           1
1995        3           1
```

### Roll Up

Conversely, a __roll up__ is when we move from a _granular view_ to a more _generalised_ view.

In SQL, we can do this by adding `WITH ROLLUP`.

```sql
SELECT
	TOP 20
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

```
BirthYear   BirthMonth  BirthDay    Cnt
----------- ----------- ----------- -----------
1981        6           16          1
1981        6           NULL        1
1981        NULL        NULL        1
1983        10          9           1
1983        10          NULL        1
1983        NULL        NULL        1
1984        8           12          1
1984        8           31          1
1984        8           NULL        2
1984        9           22          1
1984        9           NULL        1
1984        NULL        NULL        3
1985        2           27          1
1985        2           NULL        1
1985        4           12          1
1985        4           NULL        1
1985        6           13          1
1985        6           NULL        1
1985        8           15          1
1985        8           NULL        1
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
	TOP 20
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

```
BirthYear   BirthMonth  BirthDay    Cnt
----------- ----------- ----------- -----------
1993        1           1           1
NULL        1           1           1
1994        4           1           1
NULL        4           1           1
2000        6           1           1
NULL        6           1           1
1992        8           1           1
1995        8           1           1
NULL        8           1           2
NULL        NULL        1           5
1993        5           2           1
1995        5           2           1
NULL        5           2           2
1996        8           2           1
NULL        8           2           1
2002        9           2           1
NULL        9           2           1
2003        11          2           1
NULL        11          2           1
NULL        NULL        2           5
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
	TOP 10
	stats.Normal(25,5, RAND(),RAND()) AS age
FROM music.Users
```
As you can see, everyone is assigned the same random age!

```
age
----------------------
29.7755011301385
29.7755011301385
29.7755011301385
29.7755011301385
29.7755011301385
29.7755011301385
29.7755011301385
29.7755011301385
29.7755011301385
29.7755011301385
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