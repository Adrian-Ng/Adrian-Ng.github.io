---
title: "DML: UPDATE Statements"
permalink: /SQL/dml/update/
excerpt: "A look at ways of writing UPDATE statements in SQL by Adrian Ng"
toc: true
---

`UPDATE` is used to _change_ data in a table.

With `UPDATE`, we can change the data in our table to something else.
And we have the flexibility to update the table such that we change either:
* the entire table 
* a subset 
* a single value

Furthermore, we can use a `CASE` statement to apply our update via branching logic.

## Entire Table

Let's set the entire `Duration` column to `NULL`.

```sql
UPDATE dbo.Song
SET Duration = NULL;
```

## Single value

Let's change  song in `dbo.Songs`..

```sql
UPDATE dbo.Song
SET Duration =  600
WHERE SongID = 1;
```

## Subset

Let's subset the tuples that match to another table `dbo.GoodSongs` and update the `Description` field.

```sql
UPDATE A
SET A.Description = 'Good Song'
FROM dbo.Song AS A
WHERE EXISTS (SELECT 1 FROM dbo.GoodSongs WHERE A.SongID = SongID)
```

## CASE Statement

Let's update the entire table. But use a case statement to update the `Description` field based on `Duration`.

```sql
UPDATE dbo.Song
SET Description = CASE WHEN Duration >= 300 THEN 'Long Song' ELSE 'Short Song' END
```


