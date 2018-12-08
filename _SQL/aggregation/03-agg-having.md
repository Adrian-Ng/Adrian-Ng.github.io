---
title: "Summarizing Data: Having Clause"
permalink: /SQL/aggregation/having/
excerpt: "Aggregating with the Having Clause by Adrian Ng"
toc: true
mathjax: true
header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/headers/aggregation.jpg
---

## Intro to Having

The Having Clause lets us filter our data on some condition dependent on the output of some aggregation function.
It is similar to a `WHERE` clause in that we a specifying a __search condition__ on our query.

## Questions

We could use it to answer questions like:

* Which albums in our database have more than 10 songs?
* Which email addresses appear more than once in our table?

## Example

Let's try to answer the first question.

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

### SQL Having


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

Odd that we only have just three albums in the database with more than 10 songs!

This is what happens when you use semi-randomly generated dummy data.
{: .notice--info}

## Further analysis

We could now ask:

* How many songs do each of these albums have?
* What are the actual names of these albums?
* Who are the main artists for these albums?

### SQL

For the first question, we simpply add `COUNT(*)` to the `SELECT`.
The last two questions can be answered if we join to `music.Album`.

This table is _normalized_ which is important because we will be using `INNER JOIN`.
Therefore we don't need to worry about the __cartesian product__ returning more rows than we started with!

```sql
SELECT
	music.Album.AlbumId
,	title
,	MainArtist
,	COUNT(*) AS SongCount
FROM	music.AlbumTrack
INNER JOIN	music.Album
ON music.AlbumTrack.AlbumID = music.Album.AlbumID
GROUP BY 
	music.Album.AlbumId
,	title
,	MainArtist
HAVING COUNT(*) > 10;
```



### Output


$$
\begin{array}{|c|c|c|c|}
\hline
\text{AlbumID} & \text{Title} & \text{MainArtist} & \text{SongCount} \\ 
\hline	
		51 
	& 	\text{Now that's what I call music}
	& 	\text{NULL} 
	& 	15 
	\\	
		52
	&	\text{Music for tobogganing} 
	& 	\text{NULL} 
	& 	15 
	\\	
		53
	&	\text{Best of}
 	& 	\text{NULL} 
 	&	15 
 	\\
\hline
\end{array}
$$

Now we know the album titles, main artist and song count.
These albums lack a main artist, which means they are compilation albums.
By sheer coincidence, they each have 15 songs.

