---
title: "DML: SELECT INTO Statements"
permalink: /SQL/dml/selectinto/
excerpt: "A really quick look at SELECT INTO statements in SQL by Adrian Ng"
toc: true
---

## Syntactic Suguar

`SELECT INTO` is an example of __syntactic sugar__.
It is both **DDL** and **DML** because it is both `CREATE TABLE`, and `INSERT INTO`.

Put simply, allows us to easily _copy_ data from one table into a new table.
We write it like this:

```sql
SELECT
	*
INTO dbo.newSongTable
FROM dbo.Song;
```

## Under the hood

This statement automatically invokes this `CREATE TABLE` statement:

```sql
CREATE TABLE dbo.newSongTable 
	ID		int IDENTITY(1,1) PRIMARY KEY
,	Name		nvarchar(100)
,	Duration	int);
```
Note: This schema for `dbo.newSongTable` is identical to the source table `dbo.Songs`.
{: .notice--info}

This is followed by an `INSERT INTO`:

```sql
INSERT INTO dbo.newSongTable
SELECT
	*
FROM dbo.Songs;
```


