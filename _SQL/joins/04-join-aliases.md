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

Note how it is still obvious that `alb.Title` is a projection of `Album`.
{: .notice--warning}


## Table Aliases

In the above example, we can see a few __Table Aliases__, these being `trk`, `alb`, and `sng`.

Now if i want to reference the `Album` relation, I can simply use the alias `alb` (and pray that _Intellisense_ is working).

Notice how in the `SELECT`, it is immediately clear what fields I'm using and which relations they come from. This is simply because I've chosen sensibly named aliases.

These alias also provide me the convenience of not having tobe verbose with table references. This mainly comes into play in the `JOIN` predicates.

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

You may feel that this is more readable. 

And certainly there are situations where it is possible for aliases to make things more complicated instead...

### Alphabetical Aliasing

I had a manager once suggest I adopt this manner of aliasing. But I am not sure that it makes any sense.

Let's take the original query and change all the aliases to _letters of the alphabet_.

```sql
	a.AlbumID
,	b.Title AS AlbumTitle 
,	a.SongID
,	a.TrackNo
,	c.Name AS SongTitle
FROM		AlbumTrack 	AS a
INNER JOIN	Album 		AS b
ON a.AlbumID = b.AlbumID
INNER JOIN	Song 		AS c
ON a.SongID = c.SongID;
```
The idea here is that we can be consistent across all our queries with our table aliases.
That way, we always know that the first table is `a`, followed by `b` and so on...

One potential benefit from encoding via alphabet is that it allows us to make use of cardinality of The Alphabet.
That is, The Alphabet is an ordered sequence and this implies therefore that the ordering by which we alias our tables is important.

I disagree that it is important enough to sacrifice the readability of aliases, which is the whole point.

Consider this `INNER JOIN`.

```sql
FROM		AlbumTrack 	AS a
INNER JOIN	Album 		AS b
ON a.AlbumID = b.AlbumID
```

It could be written as below and produce the same result.

```sql
FROM		Album 		AS a
INNER JOIN	Album Track	AS b
ON a.AlbumID = b.AlbumID
```

Additionally, order of the groupings of multiple joins does not matter:

```sql
FROM		AlbumTrack 	AS a
INNER JOIN	Album 		AS b
ON a.AlbumID = b.AlbumID
INNER JOIN	Song 		AS c
ON a.SongID = c.SongID;
```

The above is equivalent to:

```sql
FROM		AlbumTrack 	AS a
INNER JOIN	Song 		AS b
ON a.SongID = b.SongID
INNER JOIN	Album 		AS c
ON a.AlbumID = c.AlbumID;
```


Now let's consider readability.
Look at the `SELECT` and try to discern which tables the fields belong to. 
Despite our consistency in having the second table always  aliased as `b`, I don't actually know what that table really is!
That is, it is not immediately clear that `b.Title` is a projection of `Album`. 
In order to know this, I would have to remember that `Album` is the second table.
Of course, I would not know this and it would defeat the purpose of having an alias.


Inner Joins are both __commutative__ and __associative__ - the order in which you write or group them does not matter in terms of the end result.
Outer joins are _not_ commutative.
While the join order could have an  However, the _query optimizer_ will figure that out for you.
{: .notice--warning}






