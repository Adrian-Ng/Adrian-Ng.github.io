---
title: "Joins: Aliases"
permalink: /SQL/joins/aliases/
excerpt: "Aliasing is important. How to not do them"
toc: true
mathjax: true
---

`AS` after a _column_ or _table_ denotes an alias. 

```sql
SELECT
	trk.AlbumID
,	alb.Title AS AlbumTitle 
,	trk.SongID
,	trk.TrackNo
,	sng.Name AS SongTitle
FROM		AlbumTrack 	AS trk
INNER JOIN	Album 		AS alb
ON trk.AlbumID = alb.AlbumID
INNER JOIN	Song 		AS sng
ON trk.SongID = sng.SongID;
```

When you _alias_ a table, you give it a _little nickname_ that you can reference from within the query. 

For instance, this can be handy for denoting which table your fields come from. And it is definitely useful for `JOIN` predicates.

## Column Aliases

In the above example, we rename `alb.Title` to `AlbumTitle`.

In Relational Algebra, this is a _rename_.

$$
\rho_{AlbumTitle/Title}(Album)
$$



## Table Aliases

In the above example, we can see a few __Table Aliases__, these being `trk`, `alb`, and `sng`.

Now if i want to reference the `Album` relation, I can simply use the alias `alb`.

Notice how in the `SELECT`, it is immediately clear what fields I'm using and which relations they come from.

And in the `JOIN` predicate, it saves me from using a verbose table reference (which would also be valid).

### You don't have to alias if you don't want to

Aliasing is not necessary. If you want to, (or if you feel it reads better), you can avoid aliasing altogether and be explicit with your references like so:

```sql
SELECT
	AlbumTrack.AlbumID
,	Album.Title AS AlbumTitle
,	AlbumTrack.SongID
,	AlbumTrack.TrackNo
,	Song.Name AS SongTitle
FROM	AlbumTrack
INNER JOIN	Album
ON AlbumTrack.AlbumID = Album.AlbumID
INNER JOIN	music.Song
ON AlbumTrack.SongID = Song.SongID
```

You may feel that this is more readble. Afterall, there are situations where it is possible to encode the meaning of something such that it becomes too complicated to understand (see below).

### Don't do it this way

I had a colleague once suggest I do this.

Note: do not do this. It makes no sense whatsoever!
{: .notice--danger}

Let's take the original query and change all the aliases to _letters of the alphabet_.

```sql
	a.AlbumID
,	b.Title AS AlbumTitle 
,	a.SongID
,	a.TrackNo
,	c.Name AS SongTitle
FROM		AlbumTrack 	AS a
INNER JOIN	Album 		AS b
ON trk.AlbumID = alb.AlbumID
INNER JOIN	Song 		AS c
ON trk.SongID = sng.SongID;
```

By aliasing our tables in this manner, we imply that the ordering of our tables is important and immutable.



But look at the `SELECT` and try to discern which tables the fields belong to. `b.Title`, for instance is 

Inner Joins are both _commutative__ and __associative__ - the order in which you write or group them does not matter in terms of the end result.
While the join order could have an  However, the _query optimizer_ will figure that out for you.
{: .notice--warning}






