---
title: "Aggregation: Having Clause"
permalink: /SQL/aggregation/having/
excerpt: "Aggregating with the Having Clause by Adrian Ng"
toc: true
mathjax: true
---

## Intro to Having

The Having Clause lets us filter our data on some condition dependent on the output of some aggregation function.
It is similar to a `WHERE` clause in that we a specifying a __search condition__ on our query.

## Questions

We could use it to answer questions like:

* Which albums in our database have more than 10 songs?
* Which email addresses appear more than once in our table?


### music.AlbumTrack

In our music database, the relation between song and album is represented by the table `music.AlbumTrack`.
Here are the first five rows:

$$
\begin{array}{|c|c|c|}
\hline
\text{AlbumID} & \text{TrackNo} & \text{SongID} \\ 
\hline
1 & 1 & 76 \\
1 & 2 & 90 \\
2 & 1 & 32 \\
3 & 1 & 54 \\
3 & 2 & 78 \\
\hline
\end{array}
$$

`AlbumID` and `SongID` are foreign keys that relate to a row in `music.Album` and `music.Song` respectively.
This table is comprised of unique `AlbumID` and `SongID` pairs.
This is because the _participation_ between a album and a song is __many-to-many__ - 
A song can appear on many albums and an album can have many songs.

What this means for our usage is that `AlbumID` is will have repetitions. 
Each repetition represents a another song on that album.

In the below code, we aggregate by the number of songs on each album and return _only_ those albums featuring greater than 10 songs.

### SQL


```sql
SELECT
	AlbumID
FROM music.AlbumTrack
GROUP by
	AlbumID	
HAVING COUNT(*) > 5;
```

### Output

$$
\begin{array}{|c|}
\hline
\text{AlbumID} \\ 
\hline
51 \\
52 \\
53 \\
\hline
\end{array}
$$


