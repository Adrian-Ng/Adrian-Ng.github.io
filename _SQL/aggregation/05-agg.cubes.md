---
title: "Aggregation: Data Cubes"
permalink: /SQL/aggregation/cubes/
excerpt: "Aggregating with Cubes by Adrian Ng"
toc: true
mathjax: true
---



## Drill Down

We've looked at how aggregation with a single field in `GROUP BY` works.




## Roll Up

## Cubes

##

## Simulating dob

In `music.Users` we simulate `dob` by sampling from the _Normal Distribution_.


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