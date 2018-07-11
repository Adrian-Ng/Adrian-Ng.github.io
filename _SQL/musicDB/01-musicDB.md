---
title: "Music Database"
permalink: /SQL/musicDB/
excerpt: "Creating a Music DB in PostgreSQL"
toc: true
---

## DOWNLOAD

* [createdb.sql](/SQL/musicDB/createdb.sql)
* [inserts.sql](/SQL/musicDB/inserts.sql)

Note to self: move these files to a github repository... but only if you have time :)
{: .notice--info}

## Intro

Follow along with the SQL examples you see on this site with my music Database.
This is a database that attempts to mimic how data would be stored for something like a _Spotify_ clone.

### Database Diagram

![image-center](/SQL/musicDB/DatabaseDiagram.png){: .align-center}

## Readme


### CREATE SCHEMA

Before you run the create table statements, you will need to create the named schema _music_. 
This is named schema is just some good housekeeping that helps organise our tables.

If you already have this named schema in use in your database then you can skip this step! But you might want to consider using a different named schema instead!
{: .notice--warning}

```sql
CREATE SCHEMA music;
```
### CREATE TABLE statements

Next run the statements in `createdb.sql`.

### INSERT statements

Then run the statements in `inserts.sql`

### DROP TABLES

If you wish to remove these tables from your database then you can run the below statement.
The foreign key constraints dictate that these tables must be dropped in a specfic order.

```sql
	DROP TABLE 
		music.PlaylistTrack
	,	music.Playlist		
	,	music.PerformsOnSong	
	,	music.Follows
	,	music.Users	
	,	music.AlbumTrack		
	,	music.Album		
	,	music.Song		 
	,	music.Artist
	,	music.Account;	
```

