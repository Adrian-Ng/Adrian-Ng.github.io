---
title: "DDL: Drop Statements"
permalink: /SQL/ddl/drop/
excerpt: "A look at Drop Statements in SQL by Adrian Ng"
toc: true
---

## Table

Let's drop a table `dbo.Song`.

```sql
DROP TABLE dbo.Song;
```
We could even drop a whole bunch of tables:

```sql
DROP TABLE dbo.Artist, dbo.Album, dbo.Playlist;
```

Let's drop our view `dbo.vLongSong`.

```sql
DROP VIEW dbo.vLongSong;
```

Let's drop our index on `dbo.Song`.

```sql
DROP INDEX IX_NAME ON dbo.Song;
```
