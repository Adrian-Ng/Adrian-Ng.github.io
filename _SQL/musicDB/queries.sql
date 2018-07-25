
	--3a
	SELECT
		Name
	,	Email
	FROM 		mus.User AS u
	INNER JOIN	mus.Account AS a
	ON	u.AccountID = a.AccountID
	WHERE	UserID = 1;
	
	--3b
	SELECT
		UserID
	,	Name
	FROM		mus.User
	WHERE		Country = 'France'
	ORDER BY	Name Asc;
	
	--3c
	SELECT
		Title
	,	ar.Name AS MainArtistName
	FROM		mus.Album AS al
	LEFT JOIN	mus.Artist AS ar
	ON 			al.MainArtist = ar.ArtistID
	ORDER BY	ar.Name ASC;
	
	--3d
	SELECT
		ar.Name AS ArtistName
	,	COUNT(DISTINCT f.UserID) 	AS FollowerCount
	,	COUNT(DISTINCT pos.SongID)	AS SongCount
	FROM		mus.Artist AS ar
	INNER JOIN	mus.Follows AS f
	ON			ar.ArtistID = f.ArtistID
	INNER JOIN	mus.PerformsOnSong AS pos
	ON			ar.ArtistId = pos.ArtistID
	GROUP BY	ar.Name;
	
	--3e
	SELECT
		s.Name	AS NameofSongThatAppearsOnMostPlaylists
	FROM		mus.PlaylistTrack AS pt
	INNER JOIN	mus.Song AS s
	ON			pt.SongID = s.SongID
	GROUP BY 	s.Name
	ORDER BY	COUNT(pt.SongId) DESC	
	LIMIT		1;
	
	--3f
	WITH cteSongsOnAlbums AS (
		SELECT 
			DISTINCT 
			at.SongID
		,	AlbumId
		,	ArtistID
		,	ROW_NUMBER() OVER (PARTITION BY ArtistID, AlbumID ORDER BY AlbumID, ArtistID) AS RN
		FROM		mus.AlbumTrack AS at
		INNER JOIN 	mus.PerformsOnSong AS pos
		ON		at.SongID = pos.SongID
	)
	SELECT
		DISTINCT a.Name
	,	COUNT(DISTINCT AlbumID) AlbumCount
	FROM	cteSongsOnAlbums AS s
	INNER JOIN 	mus.Artist AS a
	ON 		a.ArtistID = s. ArtistID
	WHERE RN > 1
	GROUP BY a.Name;
	