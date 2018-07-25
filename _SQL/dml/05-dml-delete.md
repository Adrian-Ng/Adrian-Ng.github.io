---
title: "DML: DELETE Statements"
permalink: /SQL/dml/delete/
excerpt: "A look at ways of writing DELETE statements in SQL by Adrian Ng"
toc: true
---

When you write a `DELETE` statement, it's because you want to delete entire tuples from your table.

Just like `UPDATE`, we have a great deal of flexibility over how many tuples we delete. 
We can delete either:
* all tuples
* a subset of tuples
* a single tuple

## All tuples

Let's delete all the tuples in `dbo.Songs`.

```sql
DELETE dbo.Songs;
```

## Subset of Tuples

Let's delete all the tuples in `dbo.Songs` that match to `dbo.BadSongs`.

```sql
DELETE A
FROM dbo.Songs AS a
WHERE EXISTS (SELECT 1 FROM dbo.BadSongs WHERE a.SongID = SongID);
```

## Single Tuple

Let's delete `SongID = 1` from `dbo.Songs`.

```sql
DELETE dbo.Songs
WHERE SongID = 1;
```
