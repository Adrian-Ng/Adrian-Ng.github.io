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
* Data Manipulation Language (DML)

## Data Definition Language

Data Definition Language is what we use when we are creating, altering, or removing database objects.
For instance:
* `CREATE TABLE`
* `ALTER TABLE` 
* `DROP TABLE`

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

Now the values of `ID` will be generated automatically and correctly as the table grows.
One less thing to worry about.

### ALTER

Now say we've decided that we don't like having the _Artist_ field in `dbo.Song` because we think Artists should get their own table.

So we will remove it from our table using `DROP COLUMN`.

```sql
ALTER TABLE dbo.Song
DROP COLUMN Artist;
```

But we've also realised that it would be helpful if we could store the duration of each song in this table instead.

Let's measure the duration in seconds so we can store this as an integer.

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
* returning data with `SELECT` 
* populating a table with `INSERT`
* changing data with `UPDATE`
* removing data with `DELETE`

### SELECT

The `SELECT` statement is our bread and butter in the SQL world (ed: why is it not at the top of this page then?). 
And there are a lot of way of augmenting it in order to define exactly what data we want it to return.

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

### INSERT INTO

The above `SELECT` implies that `dbo.Songs' only has 5 songs.
Let's populate it with more songs.

```sql
INSERT INTO dbo.Song
VALUES
	('The Tide Is High', 231)
,	('Red Red Wine',182)
,	('Do You Really Want To Hurt Me',263)
,	('Relax',238)
,	('Gold',231);
```

Now, manually entering data into our table in this fashion is really slow and tedious.
Suppose I've got another table, `dbo.moreSong` which has many songs in it and has both columns I need: `SongName` and `Duration`.

```sql
INSERT INTO dbo.Song
SELECT
	SongName
,	Duration
FROM	dbo.moreSong;
```

### SELECT INTO

`SELECT INTO` is an interesting example of syntactic sugar.
It both **DDL** and **DML** because it comprises `CREATE`, `SELECT`, and `INSERT`.

Put simply, allows us to easily _copy_ data from one table by creating another table.

```sql
SELECT
	*
INTO dbo.newSongTable
FROM dbo.Song;
```

### UPDATE

With `UPDATE`, we can change the values in our table to something else.

Let's rename _Billie Jean_ to _Thriller_.

```sql
UPDATE dbo.Song
SET 'Thriller'
WHERE Name = 'Billie Jean';
```

### DELETE

Suppose it turns out we're not allowed to have any Thriller in our database (the lawyers say no).
And we _have_ to delete it from _Songs_.

```sql
DELETE dbo.Song
WHERE Name = 'Thriller';
```

