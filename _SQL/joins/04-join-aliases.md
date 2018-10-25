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


## Table Aliases

In the above example, we can see a few __Table Aliases__, these being `trk`, `alb`, and `sng`.

Now if i want to reference the `Album` relation, I can simply use the alias `alb` (and pray that _Intellisense_ is working).

Notice how in the `SELECT`, it is immediately clear what fields I'm using and which relations they come from. This is simply because I've chosen sensibly named aliases.

I've chosen to use short aliases. So my table references are not as verbose. This mainly comes into play in the `JOIN` predicates.

### You don’t have to alias if you don’t want to

Aliasing is not necessary (except in self-joins!). If you want to, you can avoid aliasing altogether and be explicit with your references like so:

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

## Alphabetical Table Aliases = BAD

I had a manager once suggest I adopt this manner of aliasing. But I am not sure that it makes any sense.

Let's take the original query and change all the aliases to _letters of the alphabet_.

```sql
SELECT
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
### Why alphabet?

One idea here is that we can be consistent across all our queries with our table aliases.
That way, we always know that the first table is `a`, followed by `b` and so on... 

The obvious benefit is that it allows us to make use of __Cardinality of The Alphabet__.
That is, The Alphabet is an ordered sequence and if the ordering of our tables is important then we might want to represent that importance via our aliases.

But aliases are just _syntactic sugar_. 
As I mentioned above, you don't even need to have aliases. 
The point of an alias is to __improve readability__.

### Readability
Let's focus on this part:
```sql
SELECT
	a.AlbumID
,	b.Title AS AlbumTitle 
,	a.SongID
,	a.TrackNo
,	c.Name AS SongTitle
```

Try to discern which tables the fields belong to.

Obviously, `a.AlbumID` comes from `a`. 
Likewise, `b.Title` comes from `b`. 
But what tables are these?

In order for the alias to have any __meaning__, we need to peruse the query in its entirely.
That is, these aliases provide no benefit in _readability_.

### Join Order

However, let's say we are happy to live with this concession.
The 

The ordering of our tables is not important when it comes to the `INNER JOIN`.


An `INNER JOIN` is __commutative__.

```sql
FROM		AlbumTrack 	AS a
INNER JOIN	Album 		AS b
ON a.AlbumID = b.AlbumID
```

The above could be written as below and produce the same result.

```sql
FROM		Album 		AS a
INNER JOIN	Album Track	AS b
ON a.AlbumID = b.AlbumID
```

An `INNER JOIN` is __associative__.
The order of the groupings of multiple joins does not matter:

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

In terms of the execution plan, there may be some optimal ordering. However, the _query optimizer_ will figure that out for you.
{: .notice--warning}




## Column Aliases

```sql
SELECT
	b.Title AS AlbumTitle
... 
```
In the above example, we rename `alb.Title` to `AlbumTitle`.


Note how it is still obvious that `alb.Title` is a projection of `Album`, thanks to the alias.
{: .notice--warning}

In Relational Algebra, this is a _rename_.

$$
\rho_{AlbumTitle/Title}(Album)
$$