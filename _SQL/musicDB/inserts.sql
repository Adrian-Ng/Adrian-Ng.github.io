	--POPULATE ACCOUNTS
	INSERT INTO [music].Account
	(	email)
	VALUES
	('sfreeman0@etsy.com'),
	('crodriguez1@va.gov'),
	('krobertson2@state.tx.us'),
	('pfoster3@earthlink.net'),
	('gsnyder4@cargocollective.com'),
	('ctucker5@un.org'),
	('fwilson6@chron.com'),
	('fbrown7@goo.gl'),
	('brogers8@noaa.gov'),
	('ahunter9@howstuffworks.com'),
	('mbella@1und1.de'),
	('dwatsonb@narod.ru'),
	('rrogersc@United States.com.cn'),
	('sarmstrongd@google.com'),
	('wkellye@usda.gov'),
	('jwilliamsf@mac.com'),
	('dfowlerg@bloomberg.com'),
	('rhudsonh@berkeley.edu'),
	('jdeani@facebook.com'),
	('whuntj@i2i.jp'),
	('mhernandezk@netvibes.com'),
	('lmurphyl@senate.gov'),
	('aarmstrongm@google.de'),
	('drusselln@4shared.com'),
	('csmitho@jugem.jp'),
	('wgonzalesp@webs.com'),
	('eelliottq@ed.gov'),
	('jdavisr@jugem.jp'),
	('pdiazs@cnbc.com'),
	('jlongt@vimeo.com'),
	('rrobinsonu@chicagotribune.com'),
	('mrussellv@gov.uk'),
	('jevansw@mac.com'),
	('jgutierrezx@godaddy.com'),
	('ppayney@washington.edu'),
	('cortizz@ucsd.edu'),
	('jmason10@miibeian.gov.cn'),
	('egonzales11@linkedin.com'),
	('nstephens12@ifeng.com'),
	('lromero13@uol.com.br'),
	('jcarr14@hostgator.com'),
	('pwillis15@networksolutions.com'),
	('wyoung16@wikia.com'),
	('nbishop17@intel.com'),
	('gschmidt18@blinklist.com'),
	('sstewart19@alibaba.com'),
	('rcook1a@com.com'),
	('ecarroll1b@google.cn'),
	('gweaver1c@cdbaby.com'),
	('vcarter1d@parallels.com'),
	('lrose1e@google.com.br'),
	('dhenry1f@imgur.com'),
	('jrobinson1g@senate.gov'),
	('jsnyder1h@etsy.com'),
	('jlittle1i@nature.com'),
	('bdaniels1j@pinterest.com'),
	('medwards1k@rambler.ru'),
	('pbrown1l@home.pl'),
	('jrivera1m@state.gov'),
	('jwhite1n@reddit.com'),
	('sray1o@cornell.edu'),
	('eedwards1p@usnews.com'),
	('fpierce1q@un.org'),
	('swilliams1r@pbs.org'),
	('dhansen1s@google.com.br'),
	('dfox1t@washingtonpost.com'),
	('bturner1u@newsvine.com'),
	('kkelly1v@walmart.com'),
	('tmorrison1w@marriott.com'),
	('gjohnson1x@nsw.gov.au'),
	('jjordan1y@ameblo.jp'),
	('ekelly1z@utexas.edu'),
	('ppatterson20@msn.com'),
	('khenry21@cnet.com'),
	('kpeters22@xrea.com'),
	('jthompson23@xing.com'),
	('hlynch24@4shared.com'),
	('mrose25@cloudflare.com'),
	('bfisher26@imageshack.us'),
	('arobertson27@studiopress.com'),
	('sgarcia28@npr.org'),
	('wnelson29@google.com.hk'),
	('agonzales2a@umich.edu'),
	('gbrown2b@histats.com'),
	('lgibson2c@wikimedia.org'),
	('jmendoza2d@surveymonkey.com'),
	('aryan2e@over-blog.com'),
	('ahawkins2f@hatena.ne.jp'),
	('jcoleman2g@trellian.com'),
	('pschmidt2h@dailymotion.com'),
	('fgeorge2i@state.gov'),
	('raustin2j@msu.edu'),
	('earnold2k@stumbleupon.com'),
	('bstone2l@yellowpages.com'),
	('ahart2m@rediff.com'),
	('mharper2n@mozilla.com'),
	('pwright2o@reference.com'),
	('rjohnston2p@discovery.com'),
	('jgutierrez2q@tinypic.com'),
	('rgutierrez2r@desdev.cn');
	GO
	--POPULATE

	INSERT INTO music.Artist
	(	Name
	,	Country
	,	AccountID)
	VALUES
	('Early Paragon','United States',1),
	('Violin Of The Vegas','United Kingdom',NULL),
	('Heavy Turtle','France',NULL),
	('Southern Carousel','United States',NULL),
	('Blitz Angel','Russia',NULL),
	('Smurf Of Magazine','Japan',NULL),
	('Guided Verbose','United Kingdom',NULL),
	('Above Morale','United States',NULL),
	('Wily Hallucination','Ukraine',NULL),
	('Project To Critical','United States',NULL),
	('Up Implant','Portugal',NULL),
	('Drone Zodiac','Portugal',NULL),
	('Hiding Request','Cyprus',NULL),
	('Undiscovered Gutter','Lebanon',NULL),
	('Keen Dwarf','Canada',NULL),
	('Grand Range','France',16),
	('Punctual Fiction','United States',17),
	('Even Moral','Sweden',NULL),
	('Skunk Reef','Australia',NULL),
	('Doctrine Above Shame','Egypt',NULL),
	('Will-Trantow','United Kingdom',NULL),
	('Unformed Martyr','Tanzania',NULL),
	('Bizarre Tone','France',NULL),
	('Exercise Godfather','Germany',NULL),
	('Maroon Kitten And The Rib','United States',NULL),
	('Intangible Soap','Tonga',NULL),
	('Edge Of Lane','Bolivia',NULL),
	('Primary Lizard','Germany',NULL),
	('Skiles Club','United States',NULL),
	('Trip Exam','United States',NULL),
	('Vegan Ladder','United States',NULL),
	('Bella Senior','Germany',NULL),
	('Sucky Formula','Russia',NULL),
	('Gruesome Climax','Venezuela',NULL),
	('Smelling Panic','Canada',NULL),
	('Turbo Of Bison','Mexico',NULL),
	('Robotic Album','Vietnam',NULL),
	('Neon London And The Blunt Skank','United States',NULL),
	('Peaceful Gap And The Angle','United States',39),
	('Jungle Okra','United States',NULL),
	('Spencer Club','Germany',41),
	('Prophetic Punker And The Dumb Reverb','France',NULL),
	('Lawn Of Global','France',NULL),
	('Rapid Interior','United States',NULL),
	('Proficiency Eyelid','United States',NULL),
	('Lucid Nomad','Germany',NULL),
	('Goyette Band','Canada',NULL),
	('Incomplete Sharp','France',NULL),
	('Hahn-Wolf','Russia',NULL),
	('Muse Of Charity','Russia',NULL),
	('From Rocket','Peru',NULL),
	('Taking Of The Idiotic','Uganda',NULL),
	('Amplified Fame','United States',NULL),
	('Above Month','United States',NULL),
	('Stinking Cake','United States',NULL),
	('Temporary Liberation','Czech Republic',NULL),
	('Red Hunger','Canada',NULL),
	('Numb Toaster','Germany',NULL),
	('Below Wax','United States',NULL),
	('Grammar Vacant','Canada',NULL),
	('Jacket Out Claw','United States',NULL),
	('Density Prick','United States',NULL),
	('Painter Freak','Mongolia',NULL),
	('Witty Cadet','Germany',NULL),
	('Artery Of The Botched Quiver','United States',NULL),
	('Mistake Intrusion','Syria',NULL),
	('Stage Of Zodiac','United Kingdom',NULL),
	('Bunker Of The Invincible Fruit','Germany',NULL),
	('Upon Grunge','France',NULL),
	('Inverted Accomplice','Germany',NULL),
	('Gaseous Muscle','Poland',NULL),
	('Slashing Spray','United States',NULL),
	('Mangled Greatest','United States',NULL),
	('Corrupt Medic','Nigeria',NULL),
	('Flooded Believer','United States',NULL),
	('Adversity United','France',NULL),
	('Undercover Of The Quick','Canada',NULL),
	('Kinetic Ass','South Korea',NULL),
	('Exam Cannibal','Gabon',NULL),
	('Tense Passion','United States',NULL),
	('Gasoline Exercise','France',NULL),
	('Pacific Euphoria','France',NULL),
	('Petite Chalk Of The Experimental Reception','Mexico',NULL),
	('Learning Worship','United Kingdom',NULL),
	('Offset Of The Inverted Crustb','Nigeria',NULL),
	('Exploding Flare','France',NULL),
	('Legal Of The Wooden','United Kingdom',87),
	('Kind Software And The Cave','Mauritius',NULL),
	('Couch Two-piece','Honduras',NULL),
	('Always Yawn','Yemen',NULL),
	('Everything Rake','United States',91),
	('Horsefly Of The Missle','Bosnia and Herzegovina',NULL),
	('Pusher Maggot','Jamaica',NULL),
	('Saving Beast','Czech Republic',NULL),
	('Driving Explosion','France',NULL),
	('Gifted Score','Panama',NULL),
	('Bionic Coalition','Morocco',NULL),
	('Pyramid Sinner','United States',NULL),
	('Aqua Eclipse','France',NULL),
	('Forsaken Counselor','France',NULL);

	--USER
	INSERT INTO [music].[user]
	(	Name
	,	Country
	,	AccountID)
	VALUES
	('Keith Ryan','Japan',1),
	('Julie Brown','France',2),
	('Helen Hudson','United States',3),
	('Anne Sanchez','Japan',4),
	('Sharon Knight','Poland',5),
	('Jesse Fowler','United States',6),
	('Kathy Woods','Sri Lanka',7),
	('Denise Sims','United Kingdom',8),
	('Victor Boyd','Canada',9),
	('Christopher Young','Sweden',10),
	('Marie Nelson','Portugal',11),
	('Eugene Elliott','United States',12),
	('Carol Hill','Russia',13),
	('Lois Cook','Sweden',14),
	('Jennifer Hill','United States',15),
	('Susan Wood','United States',16),
	('Sara Stanley','Mayotte',17),
	('Lisa West','Sweden',18),
	('Eric Sanchez','United States',19),
	('Laura Porter','Germany',20),
	('Julie Stevens','Mauritius',21),
	('Richard Roberts','Tanzania',22),
	('Irene Jordan','Greece',23),
	('Frank Lynch','Uruguay',24),
	('Jose Rice','Russia',25),
	('Wanda Ryan','France',26),
	('Arthur Flores','France',27),
	('Linda Walker','United States',28),
	('Rebecca Carter','Greece',29),
	('Roy Hansen','Germany',30),
	('Jeffrey Allen','Morocco',31),
	('Rose Green','United States',32),
	('Anna Schmidt','United States',33),
	('Timothy Allen','France',34),
	('Johnny Hall','France',35),
	('Robin Holmes','United States',36),
	('Roger Chavez','Ethiopia',37),
	('Gregory Lawrence','Russia',38),
	('Kevin Harris','Macedonia',39),
	('Gloria Simpson','Gambia',40),
	('Mark Matthews','Portugal',41),
	('Mildred Stephens','Jordan',42),
	('Carl Morgan','United States',43),
	('Joshua Ramirez','Yemen',44),
	('Lori Armstrong','United States',45),
	('Timothy Stewart','United States',46),
	('Todd West','Colombia',47),
	('Philip Reyes','Russia',48),
	('Adam Ortiz','United States',49),
	('Gloria Wood','United States',50),
	('Nicole Ford','Kenya',51),
	('Katherine Torres','France',52),
	('Kimberly Burton','United States',53),
	('Russell Sims','Czech Republic',54),
	('Jack Ford','United States',55),
	('Jennifer Flores','Poland',56),
	('Carlos Lewis','Serbia',57),
	('Laura Ramirez','United States',58),
	('William Hunt','Argentina',59),
	('Craig Gilbert','France',60),
	('Michelle Long','Luxembourg',61),
	('Rachel Phillips','Russia',62),
	('Charles Elliott','American Samoa',63),
	('William Scott','United States',64),
	('Rachel Nguyen','Sweden',65),
	('Kathy Bennett','United States',66),
	('Jeremy Nguyen','Russia',67),
	('Julie Perry','Peru',68),
	('Jerry Peters','Kazakhstan',69),
	('Wayne Kelly','France',70),
	('Thomas Martinez','Serbia',71),
	('Sharon Vasquez','Nigeria',72),
	('Bonnie Perez','Poland',73),
	('Brandon Martin','Ethiopia',74),
	('John Mills','Japan',75),
	('Steve Woods','Argentina',76),
	('Louise James','Czech Republic',77),
	('William Robertson','United States',78),
	('Bobby Bailey','United States',79),
	('Heather Oliver','Czech Republic',80),
	('Nicole Adams','France',81),
	('Anthony Thompson','Mali',82),
	('Patricia Mccoy','United Kingdom',83),
	('Harold Morrison','Poland',84),
	('Bruce Franklin','United States',85),
	('Michael Hayes','Dominican Republic',86),
	('Peter Dixon','Argentina',87),
	('Nicole Harrison','Malta',88),
	('Norma Moore','United States',89),
	('Dennis Ruiz','Germany',90),
	('Christine Alvarez','Czech Republic',91),
	('Angela Alvarez','United States',92),
	('Marie Cunningham','United Kingdom',93),
	('Melissa Medina','United States',94),
	('Diana Knight','El Salvador',95),
	('Richard Jenkins','Haiti',96),
	('Andrea Cox','Colombia',97),
	('Tammy Gray','Russia',98),
	('Donna Miller','Finland',99),
	('Jessica Grant','Germany',100);
	
	--FOLLOWS
	INSERT INTO [music].Follows
	SELECT
		TOP 200
		ArtistID
	,	UserID
	FROM		[music].Artist
	CROSS JOIN	[music].[User]
	ORDER BY 	NEWID();
	
	--SONG
	
	INSERT INTO [music].Song
	(	Name
	,	Duration	)
	VALUES
	('Glittering Dynamite',517),
	('Pacific Creativity',286),
	('Mystic Ignorance',321),
	('Nothing But A Sale',298),
	('Reckless Look',516),
	('Eternal Rocket',309),
	('Deadly Tobacco',194),
	('Deadly Twister',472),
	('Green Doubt',560),
	('Impossible Psycho',464),
	('Real Dynamite',319),
	('Unconditional Realism',216),
	('Day Of The Tsunami',209),
	('My Battle',493),
	('Repeating Beauty',589),
	('Foxy Woman',509),
	('Loose Showcase',446),
	('False Mother',422),
	('Glittering Sucker',169),
	('Freezing Gun',411),
	('Wild Soldier',357),
	('Day Glo Freak',453),
	('Sanity On A Stick',426),
	('5 Dollar Weekend',224),
	('Random Showcase',452),
	('Scruitiny After Sundown',453),
	('The Ultimate Tuxedo',545),
	('The Last Interference',250),
	('Speeding Firecracker',321),
	('Fruity Sun',592),
	('My Kinda Shadow',438),
	('Foreign Intensity',511),
	('Abandoned Riff',201),
	('Vision Of Glory',378),
	('Compromise Don''t Live Here Anymore',151),
	('A Different Breed Of Truth',302),
	('Procrastination Days',289),
	('Some Kinda Twister',318),
	('Check Out The Car',224),
	('Heat Riot',135),
	('Basic Showroom',257),
	('Some Kinda Weekend',124),
	('Golden Space',497),
	('Far From Emotion',267),
	('Deafening Procrastination',256),
	('Manual Relaxation',141),
	('Crying Crusade',507),
	('Scruitiny Loves You',421),
	('Fairground Axe',370),
	('Unforgettable War',355),
	('Overt Stash',237),
	('Unforgettable Firecracker',543),
	('Impossible Bombshell',193),
	('Success Happens',327),
	('Yesterday''s Synchronisation',508),
	('Communication Circus',278),
	('Hardcore Explosion',515),
	('Wild Experience',206),
	('Robotic Rock',136),
	('Passion Laughs Atcha',147),
	('Forgotten Cafe',124),
	('Don''t Stop The Psycho',565),
	('Potent Time',317),
	('The End Of Esctasy',235),
	('Fast Adventure',587),
	('Hot Drag Queen',334),
	('Nothing But Action',369),
	('Understanding Unity',450),
	('Love Waits For Nobody',359),
	('Your Thug Belongs To Me',360),
	('Feel That Beat',450),
	('Hotshot Democracy',440),
	('I Hate Safety',214),
	('Abstraction Riot',203),
	('Good For Nothing Firecracker',457),
	('Potent Hello',224),
	('Rich Pimp',392),
	('Elegance Punch',470),
	('So Much For The Sell Out',246),
	('Superficial Culture',318),
	('Ignorance Caught Me Out',255),
	('In Search Of The Perfect Firecracker',133),
	('Twisted Battle',128),
	('Eternal Quality',164),
	('Don''t Stop The Antgonism',230),
	('100 Dollar Sweatshirt',163),
	('Act Of Fairness',191),
	('Suped Up Spotlight',321),
	('Hope Mistakes',268),
	('Hateful Anger',404),
	('The Secret Of Love',350),
	('Distress On A Plate',454),
	('Automatic Gumbo',511),
	('Mystery Waste',324),
	('Light Limo',137),
	('Burning Peepshow',362),
	('You Got The Punk',426),
	('Some Kinda Sun',537),
	('Progressive Junk',196),
	('Fairness Doesn''t Fool Around',215),
	('Wild Rider',413),
	('Friendly Sun',531),
	('Carnage Knows How To Party',222),
	('Nuclear Revolt',356),
	('Relaxation Wont Listen',556),
	('Jet Fueled Implosion',396),
	('64 Thousand Dollar Dynamite',127),
	('Don''t Stop The Gratitude',332),
	('All I Have Is My Circus',187),
	('Unstoppable Bomb',351),
	('Troubled Skydive',181),
	('Giant Whisper',407),
	('I Hate Weakness',559),
	('Vision Of Consequence',195),
	('Reckless Psycho',298),
	('Regret In America',301),
	('Death Of The Girl',586),
	('Bleeding Vixen',499),
	('Silent Spell',289),
	('Lace Race',226),
	('Ruin Can''t Stop Me',411),
	('The Point Of Sympathy',232),
	('A Touch Of Your Thorniness',364),
	('Reckless Psycho',190),
	('Dysfuntional Disaster',226),
	('Eternal Limo',457),
	('Eternal Feast',402),
	('Mainstream Fight',211),
	('Foxy Envy',204),
	('Pimp In The Darkness',270),
	('Busted With A Big Bag Of Bagels',593),
	('Realism Like This',308),
	('Morning Blackout',179),
	('Friendly Riot',191),
	('Total Psycho',214),
	('Hot Humility',435),
	('Automatic Sympathy',342),
	('Speed For Losers',461),
	('Eternal Drag Queen',435),
	('That''s The Power Of Sensationalism',513),
	('A History Of Humility',201),
	('Quality Implosion',430),
	('The All American Circus',284),
	('You Cant Stop The Feast',355),
	('Pocket Full Of Synchronisation',199),
	('Smells Like Thought',413),
	('Chasing The Cowboy',329),
	('Holy Dream',221),
	('So Much For The Skydive',347),
	('Sick Heart',288),
	('A Mighty Alley',361),
	('Hotshot Mother',163),
	('My Wooden Smart Mouth',122),
	('Guilty Elegance',550),
	('Experimental Alley',288),
	('Thunder In A Nutshell',436),
	('Hardcore Bullet',461),
	('Suburban Entertainment',169),
	('Dude, Where''s My Hand Grenade?',292),
	('Transparent Game',595),
	('Just Another Monster',476),
	('White Hope',515),
	('Tears Of Beauty',359),
	('Destruction Casino',470),
	('Deafening Truth',366),
	('Opportunity Will Hang Us All Out To Dry',217),
	('Careless Fox',416),
	('Reason Don''t Give A Soup',310),
	('My Wooden Soul',555),
	('64 Thousand Dollar Vixen',413),
	('Expensive God',578),
	('Reckless Crusade',528),
	('Jealous Of My Crusade?',216),
	('The Secret Of Hope',219),
	('Foreign Space',236),
	('Carnage Reinterpreted',538),
	('Anarchy Without You',485),
	('Hard Talent',334),
	('Chasing Grief',494),
	('Vintage Limo',451),
	('Unforgettable Freedom',249),
	('A Touch Of Your Chick',591),
	('I Got Pollution',277),
	('Hospitality Taunts You',345),
	('American Crusade',571),
	('Electric Man',477),
	('Fantastic Space',429),
	('Missing Crusade',489),
	('Skill Can''t Stop Me',122),
	('Don''t Touch The Storm',467),
	('The Ultimate Tsunami',120),
	('Surprise Mistakes',471),
	('Hollywood Skydive',508),
	('Foxy Whippee',421),
	('The Last Shred Of Elegance',147),
	('High Speed Friendship',548),
	('Eternal Vandalism',125),
	('Manual Punk',289),
	('Mystic Game',377),
	('Habit Is Toying With Me',324);
	
	--PERFORMS ON SONG
	
	WITH cteRandomPairs AS (
		-- EVALUATE EVERY POSSIBLE COMBINATION OF SONG/ARTIST PAIRS
		SELECT
			SongID
		,	ArtistID
		FROM		[music].Song AS s
		CROSS JOIN 	[music].Artist AS a
		)
	,	ctePartition AS (
		-- ADD A FILTERING ATTRIBUTE RN SUCH THAT EACH VALUE CORRESPONDS TO A SINGLE SET OF SONGS
		SELECT
			*
		,	ROW_NUMBER() OVER (PARTITION BY SongID ORDER BY NEWID()) AS RN
		FROM 	cteRandomPairs
			)
	,	cteMainArtist AS (
		--FILTER SO THAT WE PICK THE FIRST RANDOM SET OF SONGS 
		SELECT
			SongID
		,	ArtistID
		FROM		ctePartition
		WHERE RN = 1
			)
	,	cteFeaturingArtist AS (
		-- FILTER SO THAT WE PICK FROM THE SECOND RANDOM SET OF SONGS. 
		-- THESE 40 SONGS CAN BE OUR "FEATURING ARTISTS"
		SELECT
			TOP 40
			SongID
		,	ArtistID
		FROM		ctePartition
		WHERE RN = 2
			)
		INSERT INTO [music].PerformsOnSong
		SELECT
			*
		FROM	cteMainArtist
		UNION
		SELECT
			*
		FROM	cteFeaturingArtist;
		
	--ALBUM
	INSERT INTO [music].Album
	(	Title
	,	MainArtist	)
	VALUES
	('Muse Sick-N-Hour Mess Age',74),
	('B-Day',100),
	('Miss E… So Addictive',77),
	('Big Willie Style',73),
	('Chocolate Factory',13),
	('Brain Salad Surgery',28),
	('The Spaghetti Incident?',53),
	('Steptacular',21),
	('Standing On The Shoulder Of Giants',77),
	('Supposed Former Infatuation Junkie',57),
	('Listen Without Prejudice Vol. 1',82),
	('Untitled',7),
	('Vivadixiesubmarinetransmissionplot',33),
	('Viva la Vida or Death and All His Friends',52),
	('Life in Cartoon Motion',28),
	('Tissues And Issues',76),
	('The Earth, A Small Man, His Dog And A Chicken',14),
	('The Boy Bands Have Won',47),
	('Evening Out With Your Girlfriend',19),
	('Mellon Collie And The Infinite Sadness',13),
	('Purpendicular',89),
	('Shock’n Y’all',64),
	('Popped In Souled Out',32),
	('Picturesque Matchstickable Messages From the Status Quo',7),
	('Rap-Murr-Phobia (The Fear Of Real Hip-Hop)',27),
	('The Day They Shot A Hole In The Jesus Egg: 1989-1991',67),
	('Einstürzende Neubauten',93),
	('How To Sell Your Soul To A Soulless People Who Sold Their Soul?',45),
	('Zenyatta Mondatta',72),
	('Ten New Songs',65),
	('Turtle Nipple and the Toxic Shock',62),
	('This Is It And I Am It And You Are It And So Is That And He Is It and She Is It and It Is It',9),
	('Whoa Nelly!',65),
	('Locust Abortion Technician',62),
	('All The Best Cowboys Have Chinese Eyes',77),
	('Chocolate Starfish and the Hot Dog Flavored Water',71),
	('Give a Monkey a Brain Transplant and He’ll Swear He’s the Centre of the Universe',72),
	('You Can Tune a Piano But You Can’t Tuna Fish',82),
	('A Salt With a Deadly Pepa',7),
	('From Genesis to Revelation',4),
	('When the Pawn Hits the Conflicts',82),
	('Captain Fantastic and the Brown Dirt Cowboy',44),
	('Hairway To Steven',37),
	('Me. I Am Mariah…The Elusive Chanteuse',90),
	('Kisses On The Bottom',19),
	('Allow Us To Be Frank',54),
	('Hey Man Smell My Finger',56),
	('Touch Me',63),
	('Church Clothes 3',23),
	('The Boop-A-Doo',72);
	
	--ALBUMS WITHOUT MAIN ARTIST
	INSERT INTO [music].Album
	(	Title	)
	VALUES
	('Now that''s what I call music 100'),
	('Music for tobogganing vi'),
	('Best of');
	--ALBUM TRACK
	
	WITH cteAlbumArtistSong AS (
		SELECT 
			al.AlbumID
		,	pos.*
		,	ROW_NUMBER() OVER (PARTITION BY AlbumID, SongID ORDER BY NEWID()) AS RN
		FROM		[music].Album AS al
		INNER JOIN	[music].PerformsOnSong AS pos
		ON			al.MainArtist = pos.ArtistID
		AND 		al.MainArtist IS NOT NULL
			)
	INSERT INTO [music].AlbumTrack
	SELECT
		AlbumID
	,	RANK() OVER (PARTITION BY AlbumID ORDER BY NEWID()) AS TrackNo
	,	SongID
	FROM	cteAlbumArtistSong
	WHERE	RN = 1;
	
	--SONGS THAT APPEAR ON ALBUMS WITHOUT MAIN ARTIST
	
	WITH cteSelectRandomSongs AS (
			SELECT
				AlbumID
			,	SongID
			,	ROW_NUMBER() OVER (PARTITION BY AlbumID, SongID ORDER BY NEWID()) AS RN
			FROM 		[music].Song AS s
			CROSS JOIN 	[music].Album AS a
			WHERE 		a.MainArtist IS NULL
		)
	,	cteLimit AS (
			SELECT
				AlbumID
			,	RANK() OVER (PARTITION BY AlbumID ORDER BY NEWID()) AS TrackNo
			,	SongID		
			FROM	cteSelectRandomSongs
		)
	INSERT INTO [music].AlbumTrack
	SELECT
		AlbumID
	,	TrackNo
	,	SongID		
	FROM ctelimit
	WHERE TrackNo < RAND() * 15 + 5;
	
	--PLAYLIST
	INSERT INTO [music].Playlist
	(	Title
	,	UserID)
	VALUES
	('My Playlist',49),
	('Summer 15',63),
	('Vacation Music',51),
	('going home',16),
	('Music Festival',91),
	('Happy times',51),
	('Workout music',93),
	('Can''t sleep',61),
	('Music for airports',98),
	('Driving',22);

		
	--PLAYLIST TRACK
	WITH cteRandomPairs AS (
		-- EVALUATE EVERY POSSIBLE COMBINATION OF SONG/PLAYLIST PAIRS
		SELECT
			PlaylistID
		,	SongID
		,	ROW_NUMBER() OVER (PARTITION BY PlaylistID ORDER BY NEWID()) AS RN
		FROM		[music].Playlist AS p
		CROSS JOIN	[music].Song AS s		
		)
	INSERT INTO [music].PlaylistTrack
	SELECT
		PlaylistID
	,	RANK() OVER (PARTITION BY PlaylistID ORDER BY NEWID()) AS TrackNo
	,	SongID
	FROM	cteRandomPairs
	WHERE 	RN > 1
	AND 	RN < RAND() * 50 + 5;

