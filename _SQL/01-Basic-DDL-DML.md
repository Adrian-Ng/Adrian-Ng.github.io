---
title: "SQL Basics: DDL & DML"
permalink: /SQL/Basics-DDL-DML/
excerpt: "A quick look at DDL and DML for SQL."
#toc: true
---

Structured Query Language (SQL) is an easy-to-learn, high level language that you'll find being used pretty much wherever you come across relational databases.
It's used in essentially two ways: building databases and retrieving data from these databases.
That is, we can divide the language into two broad categories: Data Definition Language (DDL) and Data Manipulation Language (DML).
Here, we will take a quick look at some basic examples of DDL and DML.

## Data Definition Language

Data Definition Language is what we use when we are creating, altering, or removing database objects.
These objects could include tables, views, or stored procedures. But this is not an exhaustive list.
The DDL for all these objects is generally the same: CREATE, ALTER, DROP.

### CREATE

Suppose I'm creating a database for a website that allows users to sign up and listen to music. 
Let's start by creating a really simple table, _Song_. 
This table would contain a record for every single song in our database.

For example, it would look something like:

ID|Name|Artist
---|---|---
1|Under Pressure|Queen & David Bowie
2|Billie Jean|Michael Jackson
3|The Winner Takes It All|ABBA
...|...|...

This is how you create this table.
```sql
CREATE TABLE dbo.Song (
	ID int IDENTITY(1,1) PRIMARY KEY
,	Name varchar(100)
,	Artist varchar(100));
```

### ALTER

Now say we've decided that we don't like having the _Artist_ field included in _Song_. 
So we want to drop it from our table. 
This is how you drop a column.

```sql
ALTER TABLE dbo.Song
DROP COLUMN Artist;
```

But we've also realised that it would be helpful if we could store the duration of each song in this table instead.
We will measure the duration in seconds and will store this as an integer.
This is how we add another column to our table:

```sql
ALTER TABLE dbo.Song
ADD Duration int;
```

Now our table looks like:

ID|Name|Duration
---|---|---
1|Under Pressure|249
2|Billie Jean|293
3|The Winner Takes It All|295
...|...|...

### DROP

To remove this table from our database, we write:

```sql
DROP TABLE dbo.Song;
```

### TRUNCATE

Say we want to drop and immediately recreate the table, we write:

```sql
TRUNCATE TABLE dbo.Song;
```

Note: This performs an operation that produces an outcome very similar to a DELETE statement (details below). 
The key difference is that TRUNCATE is DDL, whereas DELETE is DML.
This means you can _rollback_ a DELETE statement. But _not_ a TRUNCATE statement.
{: .notice--warning}

### INSERT INTO

Lastly, we probably want to insert some data into dbo.Songs. 
We have created the table. But it doesn't contain any data.

```sql
INSERT INTO dbo.Songs
VALUES
	('Under Pressure','249')
,	('Billie Jean','293')
,	('The Winner Takes It All','295')
,	('Our House','203')
,	('Take On Me','225')
```


## Data Manipulation Language

Data Manipulation Language is what we use when are working with the data _within_ the database. 
For example, this could mean retrieving data with a SELECT statement, using an UPDATE statement, or removing data with a DELETE statement.

### SELECT

The SELECT statement is our bread and butter in the SQL world (ed: why is it not at the top of this page then?). 
It's our gateway to the data. Without it, the database would be useless. Data would just sit there, not being looked at.

To start off with, let's select some data from dbo.Songs.

```sql
SELECT
	*
FROM dbo.Songs;
``` 

ID|Name|Duration
---|---|---
1|The Best|330
2|Eternal Flame|238
3|Time After Time|241
4|Take My Breath Away|256
5|

We can even limit our query to return only a specific number of results.

```sql
SELECT 
	TOP 1
	*
FROM dbo.Songs;
```

ID|Name|Duration
---|---|---
1|The Best|330

Or, if we fancied, we could order our results:

```sql
SELECT
	*
FROM dbo.Songs
ORDER BY 
	Duration DESC
,	Name ASC;
```











