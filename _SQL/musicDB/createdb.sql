	--DROP TABLES IF EXIST
	DROP SCHEMA IF EXISTS mus CASCADE;				
			
	--CREATE SCHEMA
	CREATE SCHEMA mus;
	
	--CREATE TABLES	
	-- ACCOUNT
	CREATE TABLE mus.Account
	(	AccountID 	serial PRIMARY KEY
	, 	Email 		varchar(100) NOT NULL
		);
		
	-- ARTIST
	CREATE TABLE mus.Artist
	(	ArtistID	serial PRIMARY KEY
	,	Name		varchar(100)
	,	Country		varchar(100)
	,	AccountID	int NULL
	,	FOREIGN KEY (AccountID) REFERENCES mus.Account(AccountID)
		);
	
	--USER
	CREATE TABLE mus.User
	(	UserID		serial PRIMARY KEY
	,	Name		varchar(100)
	,	Country		varchar(100)
	,	AccountID	int NULL
	,	FOREIGN KEY (AccountID) REFERENCES mus.Account(AccountID)
		);

	--FOLLOWS
	CREATE TABLE mus.Follows
	(	UserID		int
	,	ArtistID	int
	,	PRIMARY KEY(UserID, ArtistID)
	,	FOREIGN KEY (UserID) REFERENCES mus.User (UserID)
	,	FOREIGN KEY (ArtistID) REFERENCES mus.Artist (ArtistID)
		);
		
	--SONG
	CREATE TABLE mus.Song
	(	SongID		serial PRIMARY KEY
	,	Name		varchar(100)
	,	Duration	int
		);
		
	--PERFORMSONSONG
	CREATE TABLE mus.PerformsOnSong 
	(	SongID		int 
	,	ArtistID	int 
	,	PRIMARY KEY	(SongID, ArtistID)
	,	FOREIGN KEY (SongID) REFERENCES mus.Song (SongID)
	,	FOREIGN KEY (ArtistID) REFERENCES mus.Artist (ArtistID)
		);
		
	--ALBUM
	CREATE TABLE mus.Album
	(	AlbumID		serial PRIMARY KEY
	,	Title		varchar(100)
	,	MainArtist	int NULL
	,	FOREIGN KEY (MainArtist) REFERENCES mus.Artist (ArtistID)
		);
		
	--ALBUMTRACK
	CREATE TABLE mus.AlbumTrack
	(	AlbumID		int 
	,	TrackNo		int
	,	SongID		int
	,	PRIMARY KEY (AlbumID, TrackNo)
	,	FOREIGN KEY (AlbumID) REFERENCES mus.Album (AlbumID)
	,	FOREIGN KEY (SongID) REFERENCES mus.Song (SongID)
		);
	
	--Playlist
	CREATE TABLE mus.Playlist
	(	PlaylistID	serial PRIMARY KEY
	,	Title		varchar(100)
	,	UserID		int NOT NULL
	,	FOREIGN KEY (UserID) REFERENCES mus.User(UserID)
		);
		
	--PLAYLISTTRACK
	CREATE TABLE  mus.PlaylistTrack
	(	PlaylistID	int
	,	TrackNo		int
	,	SongID		int
	,	PRIMARY KEY (PlaylistID, TrackNo)
	,	FOREIGN KEY (PlaylistID) REFERENCES mus.Playlist (PlaylistID)
	,	FOREIGN KEY (SongID) REFERENCES mus.Song (SongID)
		);
	
	
	