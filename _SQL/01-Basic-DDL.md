---
title: "Basic DDL"
permalink: /SQL/Basic-DDL/
excerpt: "Quick and easy examples for CREATE, ALTER, DROP, and, Truncate."
#toc: true
---

Let's take a quick look at some of the basic Data Definition Language (DDL) in T-SQL (hereafter, just _SQL_).
This is what we use when we're creating database objects such as tables, views and stored procedures.
The DDL for all these objects is generally the same. 

Note: I am not a DBA. So if you are looking for information on how to build the perfect relational database, look elsewhere!


##CREATE

Suppose I'm creating a database for a website that allows users to sign up and listen to music. 
Let's start by creating a really simple table, _Song_. 
This table would contain a record for every single song in our database.

For example, it would look something like:

ID|Name|Artist
---|---|---
1|The Best|Tina Turner
2|Eternal Flame|The Bangles
3|Time After Time|Cyndi Lauper
...|...|...

This is how you create this table.
```sql
	CREATE TABLE dbo.Song (
		ID int IDENTITY(1,1) PRIMARY KEY
	,	Name varchar(100)
	,	Artist varchar(100)
		);
```

##ALTER

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
1|The Best|330
2|Eternal Flame|238
3|Time After Time|241
...|...|...

##DROP

To remove this table from our database, we write:

```sql
	DROP TABLE dbo.Song;
```

##TRUNCATE

Say we want to drop and immediately recreate the table, we write:

```sql
	TRUNCATE TABLE dbo.Song;
```

Note: This performs an operation that produces an outcome very similar to DELETE. The key difference is that TRUNCATE is DDL, whereas DELETE is Data Manipulation Language (DML).
This means you can _rollback_ a DELETE statement. But _not_ a TRUNCATE statement.
{: .notice--warning}











