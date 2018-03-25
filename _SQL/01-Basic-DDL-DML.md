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
DROP TABLE Song;
```

### TRUNCATE

Say we want to drop and immediately recreate the table, we write:

```sql
TRUNCATE TABLE Song;
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
Let us now put some data in there:


```sql
INSERT INTO Songs
VALUES
	('Under Pressure','249')
,	('Billie Jean','293')
,	('The Winner Takes It All','295')
,	('Our House','203')
,	('Take On Me','225')
```

### UPDATE

With UPDATE statements, we can change the values in our table to something else.
We can be as blunt or as deft as we need to be.
We can change every value in a column or just a subset of values or simply a single value.

This is how we change the name of one song in our table:

```sql
UPDATE Songs
SET 'Thriller'
WHERE Name = 'Billie Jean';
```

As such, we have now renamed _Billie Jean_ to _Thriller_.

### DELETE

Suppose it turns out we're not allowed to have any Thriller in our database. 
Therefore, we have to delete it from _Songs_.

```sql
DELETE Songs
WHERE Name = 'Thriller';
```

### SELECT

The SELECT statement is our bread and butter in the SQL world (ed: why is it not at the top of this page then?). 
Without it we would not be able to look at our data.

Let's retrieve all rows of data from Songs.

```sql
SELECT
	*
FROM dbo.Songs;
``` 

ID|Name|Duration
---|---|---
1|Under Pressure|249
3|The Winner Takes It All|295
4|Our House|203
5|Take On Me|225

Of course, _Thriller_ is no longer there!















