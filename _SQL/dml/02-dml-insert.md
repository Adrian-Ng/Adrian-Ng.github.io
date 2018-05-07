---
title: "DML: SELECT Statements"
permalink: /SQL/dml/select/
excerpt: "A look at ways of writing SELECT statements in SQL by Adrian Ng"
toc: true
---

## Inserting Values

Suppose `dbo.Songs` is empty.
Let's populate it with some songs.

```sql
INSERT INTO dbo.Song
VALUES
	('The Tide Is High', 231)
,	('Red Red Wine',182)
,	('Do You Really Want To Hurt Me',263)
,	('Relax',238)
,	('Gold',231);
```

## Inserting from SELECT

Now, manually entering data into our table in this fashion is really slow and tedious.

Suppose I've got another table, `dbo.moreSong` which has... _more_ songs (and conveniently shares the same schema).

```sql
INSERT INTO dbo.Song
SELECT
	SongName
,	Duration
FROM	dbo.moreSong;
```
This essentially copies everything from `dbo.moreSong` into `dbo.Song`.
