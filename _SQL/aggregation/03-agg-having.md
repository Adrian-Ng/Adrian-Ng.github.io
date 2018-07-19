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

* Which albums in our database have more than 5 songs?
* Which email addresses appear more than once in our table?


### music.AlbumTrack

In our music database, the relation between song and album is represented by the table `music.AlbumTrack`.
Here are the first five rows:

$$
\begin{array}{|c|c|c|}
\hline
\text{AlbumID} & \text{TrackNo} $ \text{SongID} \\ 
\hline
1 & 1 & 76 \\
1 & 2 & 90 \\
2 & 1 & 32 \\
3 & 1 & 54 \\
3 & 2 & 78 \\
\cdots & \cdots \\
\hline
\end{array}
$$

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




