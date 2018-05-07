---
title: "DDL: Create Statements"
permalink: /SQL/ddl/create/
excerpt: "A look at Create Statements in SQL by Adrian Ng"
toc: true
---

## Table

Let's create a table `dbo.Song`.

```sql
CREATE TABLE dbo.Song (
	ID		int IDENTITY(1,1) PRIMARY KEY
,	Name		nvarchar(100)
,	Duration	int);
```

## View

A view is a _stored query_ that allows us encapsulate a larger query into a database object that we can reference like a table object.

```sql
SELECT * FROM dbo.vLongSongs; -- select from view
```

To create a really simple view:

```sql
CREATE VIEW dbo.vLongSongs AS 
	SELECT
		*
	FROM dbo.Song
	WHERE Duration >= 300;
```

## Index

Let's a create a non-clustered index on dbo.Songs.

```sql
CREATE NONCLUSTERED INDEX IX_NAME ON dbo.Songs (Name);
```

## Stored Procedure

Let's create a __very simple__ stored procedure that selects 100 rows from _both_ a table and from a view.

```sql
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE dbo.spSelectTableAndView
AS
BEGIN
	SET NOCOUNT ON;
	SELECT TOP 100 * FROM dbo.Songs;
	SELECT TOP 100 * FROM dbo.vLongSongs;
END
```
