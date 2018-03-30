---
title: "SQL Basics: DDL & DML"
permalink: /SQL/Basics-DDL-DML/
excerpt: "A quick look at DDL and DML for SQL."
toc: true
---

Structured Query Language (SQL) is an easy-to-learn, high level language that you'll find being used pretty much wherever you come across relational databases.
It is used in essentially two ways: building databases and retrieving data from these databases.

That is, we can divide the language into two broad categories: 
* Data Definition Language (DDL) 
* Data Manipulation Language (DML).

On this page, we will take a quick look at some basic examples of DDL and DML.

## Data Definition Language

Data Definition Language is what we use when we are creating, altering, or removing database objects.
For instance:
* `CREATE TABLE`
* `ALTER TABLE` 
* `DROP TABLE`.

### CREATE

Suppose we are creating a database for a website that allows users to sign up and listen to music (a _Spotify_ clone). 
Let's start by creating a really simple table on the default schema: `dbo.Song`.
This table would contain a record for every single song in our database.

The column data types could be defined as:

Column|Data Type
---|---
ID|int
Name|nvarchar(100)
Artist|nvarchar(100)

And if we were to look at the data in `dbo.Song`, it could look something like:

ID|Name|Artist
---|---|---
1|Under Pressure|Queen & David Bowie
2|Billie Jean|Michael Jackson
3|The Winner Takes It All|ABBA
...|...|...

```sql
CREATE TABLE dbo.Song (
	ID	int IDENTITY(1,1) PRIMARY KEY
,	Name	nvarchar(100)
,	Artist	nvarchar(100));
```

Notice we have also added a couple things:
* the `IDENTITY` property: values of `ID` start at 1 _and_ increment by 1.
* the `PRIMARY KEY` constraint: each value must be unique and not contain any `NULL` values.


### ALTER

Now say we've decided that we don't like having the _Artist_ field in `dbo.Song` because we think Artists should get their own table (where they can live happily normalised).
So we want to remove it from our table using `DROP COLUMN`.

```sql
ALTER TABLE dbo.Song
DROP COLUMN Artist;
```

But we've also realised that it would be helpful if we could store the duration of each song in this table instead.
If we measure the duration in seconds we can store this as an integer!

```sql
ALTER TABLE dbo.Song
ADD Duration int;
```

Now our the schema of our table looks like:

Column|Data type
---|---
ID|int
Name|nvarchar(100)
Duration|int

### DROP

To remove this table from our database:

```sql
DROP TABLE dbo.Song;
```

### TRUNCATE

To drop and immediately recreate the table:

```sql
TRUNCATE TABLE dbo.Song;
```

Note: This performs an operation that produces an outcome very similar to a `DELETE` statement (details below). 
The key difference is that `TRUNCATE` is DDL, whereas `DELETE` is DML.
This means you can _rollback_ a `DELETE` statement. But _not_ a `TRUNCATE` statement.
{: .notice--warning}


## Data Manipulation Language

Data Manipulation Language is what we use when are working with the data itself. 
For example, this could mean :
* populating a table with 'INSERT'
* returning data with `SELECT` 
* changing data with `UPDATE`
* removing data with `DELETE`


### INSERT INTO

Let's return to our newly created table `dbo.Song` and populate it using `INSERT`.
We will use songs from _Now That's What I Call The 80s_.

```sql
INSERT INTO dbo.Song
VALUES
	('Under Pressure',249)
,	('Billie Jean',293)
,	('The Winner Takes It All',295)
,	('Our House',203)
,	('Take On Me',225);
```

### SELECT

The `SELECT` statement is our bread and butter in the SQL world (ed: why is it not at the top of this page then?). 
And there are a lot of way of augmenting it in order to define exactly what data we need to return.

But in its most basic configuration, `SELECT` looks like this:

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

### SELECT INTO

`SELECT INTO` is actually another example of syntactic sugar because it is both DDL _and_ DML.
It combines three operations into one: `CREATE`, `SELECT`, and `INSERT`..
In doing so this allows us to conveniently _copy_ data from one table to another (including temp tables and table variables).


```sql
SELECT
	*
INTO dbo.SomeOtherTable
FROM dbo.Song;
```

### UPDATE

With `UPDATE` statements, we can change the values in our table to something else.
We can be as blunt or as deft as we need to be.
For instance, we can change every value in a column or just a subset of values or simply a single value.

Let's rename _Billie Jean_ to _Thriller_.

```sql
UPDATE dbo.Song
SET 'Thriller'
WHERE Name = 'Billie Jean';
```

### DELETE

Suppose it turns out we're not allowed to have any Thriller in our database. 
The lawyers say no.
Therefore, we have to delete it from _Songs_.

```sql
DELETE dbo.Song
WHERE Name = 'Thriller';
```
















