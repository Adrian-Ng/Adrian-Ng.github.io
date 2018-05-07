---
title: "DDL: Alter Statements"
permalink: /SQL/ddl/alter/
excerpt: "A look at Alter Statements in SQL by Adrian Ng"
toc: true
---

## Tables

### Add

Let's add a new column to a table.

```sql
ALTER TABLE dbo.Songs
ADD year int;
```

### Drop Column

Let's remove a column from a table.

```sql
ALTER TABLE dbo.Songs
DROP COLUMN year;
```

Note: Why do we have the inconsistency that we write `DROP COLUMN` but not `ADD COLUMN`? 
Perhaps this is because `DROP` is a separate family of DDL statements from `ALTER`.
Having `DROP COLUMN` avoids the potential confusion of getting our DDL mixed up.
{: .notice--info}

## Views

Let's change the `WHERE` clause in the view `dbo.vLongSong`.

```sql
ALTER VIEW dbo.vLongSong AS -- alter instead of create
	SELECT
		*
	FROM dbo.Song
	WHERE Duration > 600; -- changed from 300
```

## Index

Let's rebuild our index.

```sql
ALTER INDEX IX_NAME ON dbo.Songs REBUILD;
```

## Stored Procedure

Let's alter our stored procedure.

```sql
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE dbo.spSelectTableAndView -- alter instead of create
AS
BEGIN
	SET NOCOUNT ON;
	SELECT TOP 1000 * FROM dbo.Songs; -- now top 1000
	SELECT TOP 1000 * FROM dbo.vLongSongs; -- now top 1000
END
```

