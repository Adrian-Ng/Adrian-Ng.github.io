	-- CREATE SCHEMA
	IF SCHEMA_ID('music') IS NULL
	CREATE SCHEMA music;

	--CREATE TABLES	
	-- ACCOUNT
	CREATE TABLE [music].[Account]
	(	[AccountID] int IDENTITY(1,1) PRIMARY KEY
	, 	[Email]		varchar(100) NOT NULL
		);
		
	-- ARTIST
	CREATE TABLE [music].[Artist]
	(	ArtistID	int IDENTITY(1,1) PRIMARY KEY
	,	Name		varchar(100)
	,	Country		varchar(100)
	,	AccountID	int NULL
	,	FOREIGN KEY (AccountID) REFERENCES [music].[Account](AccountID)
		);
	
	--USER
	CREATE TABLE [music].[User]
	(	UserID		int IDENTITY(1,1) PRIMARY KEY
	,	Name		varchar(100)
	,	Country		varchar(100)
	,	AccountID	int NULL
	,	FOREIGN KEY (AccountID) REFERENCES [music].[Account](AccountID)
		);

	--FOLLOWS
	CREATE TABLE [music].Follows
	(	UserID		int
	,	ArtistID	int
	,	PRIMARY KEY(UserID, ArtistID)
	,	FOREIGN KEY (UserID) REFERENCES [music].[User] (UserID)
	,	FOREIGN KEY (ArtistID) REFERENCES [music].Artist (ArtistID)
		);
		
	--SONG
	CREATE TABLE [music].Song
	(	SongID		int IDENTITY(1,1) PRIMARY KEY
	,	Name		varchar(100)
	,	Duration	int
		);
		
	--PERFORMSONSONG
	CREATE TABLE [music].PerformsOnSong 
	(	SongID		int 
	,	ArtistID	int 
	,	PRIMARY KEY	(SongID, ArtistID)
	,	FOREIGN KEY (SongID) REFERENCES [music].Song (SongID)
	,	FOREIGN KEY (ArtistID) REFERENCES [music].Artist (ArtistID)
		);
		
	--ALBUM
	CREATE TABLE [music].Album
	(	AlbumID		int IDENTITY(1,1) PRIMARY KEY
	,	Title		varchar(100)
	,	MainArtist	int NULL
	,	FOREIGN KEY (MainArtist) REFERENCES [music].Artist (ArtistID)
		);
		
	--ALBUMTRACK
	CREATE TABLE [music].AlbumTrack
	(	AlbumID		int 
	,	TrackNo		int
	,	SongID		int
	,	PRIMARY KEY (AlbumID, TrackNo)
	,	FOREIGN KEY (AlbumID) REFERENCES [music].Album (AlbumID)
	,	FOREIGN KEY (SongID) REFERENCES [music].Song (SongID)
		);
	
	--Playlist
	CREATE TABLE [music].Playlist
	(	PlaylistID	int IDENTITY(1,1) PRIMARY KEY
	,	Title		varchar(100)
	,	UserID		int NOT NULL
	,	FOREIGN KEY (UserID) REFERENCES [music].[User](UserID)
		);
		
	--PLAYLISTTRACK
	CREATE TABLE  [music].[PlaylistTrack]
	(	PlaylistID	int
	,	TrackNo		int
	,	SongID		int
	,	PRIMARY KEY (PlaylistID, TrackNo)
	,	FOREIGN KEY (PlaylistID) REFERENCES [music].[Playlist] (PlaylistID)
	,	FOREIGN KEY (SongID) REFERENCES [music].[Song] (SongID)
		);
	
	
	
