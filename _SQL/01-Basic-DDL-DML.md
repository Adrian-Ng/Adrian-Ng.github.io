---
title: "SQL Basics: DDL & DML"
permalink: /SQL/Basics-DDL-DML/
excerpt: "A quick look at DDL and DML for SQL."
toc: true
---

Structured Query Language (SQL) is an easy-to-learn, high level language that you'll find being used pretty much wherever you come across relational databases.
It is used in essentially two ways: building databases and retrieving data from these databases.

That is, we can divide the language into two broad categories: Data Definition Language (DDL) and Data Manipulation Language (DML).
Here, we will take a quick look at some basic examples of DDL and DML.

## Data Definition Language

Data Definition Language is what we use when we are creating, altering, or removing database objects.
These objects could include tables, views, or stored procedures. But this is not an exhaustive list.
The DDL for all these objects is generally the same: CREATE, ALTER, DROP.

### CREATE

Suppose I'm creating a database for a website that allows users to sign up and listen to music (read: Spotify clone). 
Let's start by creating a really simple table: _Songs_. 
This table would contain a record for every single song in our database.

The schema (or structure) of _Song_ would be:

Column|Data Type
---|---
ID|int
Name|nvarchar(100)
Artist|nvarchar(100)

And if we were to look at the data in _Songs_, it could look something like:

ID|Name|Artist
---|---|---
1|Under Pressure|Queen & David Bowie
2|Billie Jean|Michael Jackson
3|The Winner Takes It All|ABBA
...|...|...

This is how you create this table.
```sql
CREATE TABLE Songs (
	ID	int IDENTITY(1,1) PRIMARY KEY
,	Name	nvarchar(100)
,	Artist	nvarchar(100));
```

You can see we have defined names for its columns and their data types.

For ID, we have also defined:
* the IDENTITY property: values of ID start at 1 _and_ increment by 1.
* the PRIMARY KEY constraint: each value must be unique and not contain any NULL values.


### ALTER

Now say we've decided that we don't like having the _Artist_ field included in _Songs_ (Artists should ideally have their own table).
So we want to drop it from our table. 
This is how you drop a column from a table:

```sql
ALTER TABLE Songs
DROP COLUMN Artist;
```

But we've also realised that it would be helpful if we could store the duration of each song in this table instead.
We measure the duration in seconds so we will store this as an integer.

This is how we add another column to our table:

```sql
ALTER TABLE Songs
ADD Duration int;
```

Now our the schema of our table looks like:

Column|Data type
---|---
ID|int
Name|nvarchar(100)
Duration|int

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


## Data Manipulation Language

Data Manipulation Language is what we use when are working with the data _within_ the database. 
For example, this could mean retrieving data with a SELECT statement, using an UPDATE statement, or removing data with a DELETE statement.

Our first example is actually neither of the above!

### INSERT INTO

Recall our _Songs_ table.
We created the table. 
But it doesn't contain any data.
That's because we didn't put any data in it!



```sql
INSERT INTO dbo.Songs
VALUES
	('Under Pressure','249')
,	('Billie Jean','293')
,	('The Winner Takes It All','295')
,	('Our House','203')
,	('Take On Me','225')
```

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
1|Under Pressure|249
2|Billie Jean|293
3|The Winner Takes It All|295
4|Our House|203
5|Take On Me|225

We can even limit our query to return only a specific number of results.

```sql
SELECT 
	TOP 3
	*
FROM dbo.Songs;
```

Which would return the top three rows by ID:

ID|Name|Duration
---|---|---
1|Under Pressure|249
2|Billie Jean|293
3|The Winner Takes It All|295

Let's be more specific and query only the _Names_ of the top 3 longest songs.

```sql
SELECT
	TOP 3
	Name
FROM dbo.Songs
ORDER BY 
	Duration DESC;
```

Our result:

|Name|
---|
|The Winner Takes It All|
|Billie Jean|
|Under Pressure|













