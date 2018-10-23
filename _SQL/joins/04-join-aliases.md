---
title: "Joins: Aliases"
permalink: /SQL/joins/aliases/
excerpt: "Aliasing is important. How to not do them"
toc: true
mathjax: true
---

When you alias a table, you give it a little nickname that you can use for reference (within the scope of the query).
This can be handy for denoting which table your fields come from, for instance. And it is definitely useful for implementing `JOINS`.

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

In the above example, we can see a few __Table Aliases__ such as:
```sql
INNER JOIN	Album AS alb
```
This allows me to refer to the `Album` relation by using only the `alb` prefix.

In the `SELECT`, it is immediately clear what fields I'm using and where they come from.
In the `JOIN` predicate, it saves me from using a verbose two-part naming convention like so:

```sql
ON AlbumTrack.AlbumId = Album.AlbumID
```



## But you can be explicit if you want

Aliasing is not necessary. If you want to, or if you feel it reads better, you can avoid aliasing altogether and be explicit with your references like so:

```sql
SELECT
			music.AlbumTrack.AlbumID
		,	music.Album.Title AS AlbumTitle
		,	music.AlbumTrack.SongID
		,	music.AlbumTrack.TrackNo
		,	music.Song.Name AS SongTitle
		FROM	music.AlbumTrack
		INNER JOIN	music.Album
		ON music.AlbumTrack.AlbumID = music.Album.AlbumID
		INNER JOIN	music.Song
		ON music.AlbumTrack.SongID = music.Song.SongID
```

You may feel that this is more readble. Afterall, there are situations where it is possible to encode the meaning of something such that it becomes too complicated to understand.


## Too complex

A colleague once suggested I do this.

Note: do not do this. It is dumb.







