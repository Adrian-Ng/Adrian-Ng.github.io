---
title: "PostgreSQL: Music DB"
permalink: /SQL/musicDB/
excerpt: "Creating a Music DB in PostgreSQL"
toc: true
---

## DOWNLOAD

* [createdb.sql](/SQL/musicDB/createdb.sql)
* [inserts.sql](/SQL/musicDB/inserts.sql)

## Intro

Follow along with the SQL examples you see here with my music Database.
This is a database that attempts to mimic how data would be stored for something like a _Spotify_ clone.

### Database Diagram

![image-center](/SQL/musicDB/DatabaseDiagram.png){: .align-center}

## CREATE SCHEMA

```sql
CREATE SCHEMA music;
```


## DROP TABLES

```sql
	DROP TABLE 
		music.[PlaylistTrack]
	,	music.Playlist		
	,	music.PerformsOnSong	
	,	music.Follows
	,	music.[User]		
	,	music.AlbumTrack		
	,	music.Album		
	,	music.Song		 
	,	music.[Artist]		
	,	music.[Account];	
```
