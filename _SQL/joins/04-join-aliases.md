---
title: "Joins: Aliases"
permalink: /SQL/joins/aliases/
excerpt: "Aliasing is important. How to not do them"
toc: true
mathjax: true
---

`AS` after a _column_ or _table_ precedes an __alias__. 

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

## Column Aliases

In the above example, we rename `alb.Title` to `AlbumTitle`.

In Relational Algebra, this is a _rename_.

$$
\rho_{AlbumTitle/Title}(Album)
$$


## Table Aliases

In the above example, we can see a few __Table Aliases__, these being `trk`, `alb`, and `sng`.

Now if i want to reference the `Album` relation, I can simply use the alias `alb` (and pray that _Intellisense_ is working).

Notice how in the `SELECT`, it is immediately clear what fields I'm using and which relations they come from. This is simply because I've chosen sensibly named aliases.

These alias also provide me the convenience of not being verbose with table references. This mainly comes into play in the `JOIN` predicates.

### You don't have to alias if you don't want to

Aliasing is not necessary. If you want to, you can avoid aliasing altogether and be explicit with your references like so:

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

You may feel that this is more readble. Afterall, there are situations where it is possible for aliases to make things more complicated instead.

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
The idea here is that we can be consistent across all our queries with our aliasing.
That way, we always know that the first table is `a`, followed by `b` and so on.

This implies that the ordering by which we alias our tables is important and immutable by human hand.
But it clearly isnt.




But look at the `SELECT` and try to discern which tables the fields belong to. `b.Title`, for instance is 

Inner Joins are both _commutative__ and __associative__ - the order in which you write or group them does not matter in terms of the end result.
While the join order could have an  However, the _query optimizer_ will figure that out for you.
{: .notice--warning}






