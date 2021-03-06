--------
-- 		Data was downloaded from: https://www.kaggle.com/hugomathien/soccer
-------
DROP SCHEMA

IF EXISTS assignment_football;
	CREATE SCHEMA assignment_football;

USE assignment_football;

DROP TABLE

IF EXISTS country;
	CREATE TABLE country (
		country_id INTEGER NOT NULL
		,country_name VARCHAR(255)
		,PRIMARY KEY (country_id)
		);

LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/country.csv'
INTO TABLE country FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' ignore 1 rows;

DROP TABLE

IF EXISTS league;
	CREATE TABLE league (
		league_id INTEGER NOT NULL
		,country_id INTEGER
		,league_name VARCHAR(255)
		,PRIMARY KEY (league_id)
		,KEY country_id(country_id)
		,CONSTRAINT league_ibfk_1 FOREIGN KEY (country_id) REFERENCES country(country_id)
		);

LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/league.csv'
INTO TABLE league FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' ignore 1 rows;

DROP TABLE

IF EXISTS teams;
	CREATE TABLE teams (
		id INTEGER NOT NULL
		,team_api_id INTEGER NOT NULL
		,team_fifa_api_id INTEGER
		,team_long_name VARCHAR(255)
		,team_short_name VARCHAR(3)
		,PRIMARY KEY (team_api_id)
		,KEY team_api_id(team_api_id)
		);

LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/team.csv'
INTO TABLE teams CHARACTER

SET CP1250 FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' ignore 1 rows(id, team_api_id, @team_fifa_api_id, team_long_name, team_short_name)
SET team_fifa_api_id = nullif(@team_fifa_api_id, 'NA');

DROP TABLE

IF EXISTS players;
	CREATE TABLE players (
		id INT NOT NULL
		,player_api_id INT
		,player_name VARCHAR(255)
		,player_fifa_api_id INT
		,birthday DATE
		,height DOUBLE
		,weight SMALLINT
		,PRIMARY KEY (player_api_id)
		);

LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/player.csv'
INTO TABLE players CHARACTER

SET CP1250 FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' ignore 1 rows;


DROP TABLE

IF EXISTS matches;
	CREATE TABLE matches (
		match_id INTEGER NOT NULL
		,country_id INTEGER
		,league_id INTEGER
		,season VARCHAR(10)
		,stage INTEGER
		,match_date DATE
		,match_api_id INTEGER
		,home_team_api_id INTEGER
		,away_team_api_id INTEGER
		,home_team_goal TINYINT
		,away_team_goal TINYINT
		,home_player_1 INTEGER
		,home_player_2 INT
		,home_player_3 INT
		,home_player_4 INT
		,home_player_5 INT
		,home_player_6 INT
		,home_player_7 INT
		,home_player_8 INT
		,home_player_9 INT
		,home_player_10 INT
		,home_player_11 INT
		,away_player_1 INT
		,away_player_2 INT
		,away_player_3 INT
		,away_player_4 INT
		,away_player_5 INT
		,away_player_6 INT
		,away_player_7 INT
		,away_player_8 INT
		,away_player_9 INT
		,away_player_10 INT
		,away_player_11 INT
		,PRIMARY KEY (match_id)
		,KEY country_id(country_id)
		,KEY league_id(league_id)
		,KEY home_team_api_id(home_team_api_id)
		,KEY away_team_api_id(away_team_goal)
		,CONSTRAINT matches_ibfk_1 FOREIGN KEY (country_id) REFERENCES country(country_id)
		,CONSTRAINT matches_ibfk_2 FOREIGN KEY (league_id) REFERENCES league(league_id)
		,CONSTRAINT matches_ibfk_3 FOREIGN KEY (home_team_api_id) REFERENCES teams(team_api_id)
		,CONSTRAINT matches_ibfk_4 FOREIGN KEY (away_team_api_id) REFERENCES teams(team_api_id)
		,CONSTRAINT matches_ibfk_5 FOREIGN KEY (home_player_1) REFERENCES players(player_api_id)
		,CONSTRAINT matches_ibfk_6 FOREIGN KEY (home_player_2) REFERENCES players(player_api_id)
		,CONSTRAINT matches_ibfk_7 FOREIGN KEY (home_player_3) REFERENCES players(player_api_id)
		,CONSTRAINT matches_ibfk_8 FOREIGN KEY (home_player_4) REFERENCES players(player_api_id)
		,CONSTRAINT matches_ibfk_9 FOREIGN KEY (home_player_5) REFERENCES players(player_api_id)
		,CONSTRAINT matches_ibfk_10 FOREIGN KEY (home_player_6) REFERENCES players(player_api_id)
		,CONSTRAINT matches_ibfk_11 FOREIGN KEY (home_player_7) REFERENCES players(player_api_id)
		,CONSTRAINT matches_ibfk_12 FOREIGN KEY (home_player_8) REFERENCES players(player_api_id)
		,CONSTRAINT matches_ibfk_13 FOREIGN KEY (home_player_9) REFERENCES players(player_api_id)
		,CONSTRAINT matches_ibfk_14 FOREIGN KEY (home_player_10) REFERENCES players(player_api_id)
		,CONSTRAINT matches_ibfk_15 FOREIGN KEY (home_player_11) REFERENCES players(player_api_id)
		,CONSTRAINT matches_ibfk_16 FOREIGN KEY (away_player_1) REFERENCES players(player_api_id)
		,CONSTRAINT matches_ibfk_17 FOREIGN KEY (away_player_2) REFERENCES players(player_api_id)
		,CONSTRAINT matches_ibfk_18 FOREIGN KEY (away_player_3) REFERENCES players(player_api_id)
		,CONSTRAINT matches_ibfk_19 FOREIGN KEY (away_player_4) REFERENCES players(player_api_id)
		,CONSTRAINT matches_ibfk_20 FOREIGN KEY (away_player_5) REFERENCES players(player_api_id)
		,CONSTRAINT matches_ibfk_21 FOREIGN KEY (away_player_6) REFERENCES players(player_api_id)
		,CONSTRAINT matches_ibfk_22 FOREIGN KEY (away_player_7) REFERENCES players(player_api_id)
		,CONSTRAINT matches_ibfk_23 FOREIGN KEY (away_player_8) REFERENCES players(player_api_id)
		,CONSTRAINT matches_ibfk_24 FOREIGN KEY (away_player_9) REFERENCES players(player_api_id)
		,CONSTRAINT matches_ibfk_25 FOREIGN KEY (away_player_10) REFERENCES players(player_api_id)
		,CONSTRAINT matches_ibfk_26 FOREIGN KEY (away_player_11) REFERENCES players(player_api_id)
		);

LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/matches.csv'
INTO TABLE matches FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' ignore 1 rows(match_id, country_id, league_id, season, stage, match_date, match_api_id, home_team_api_id, away_team_api_id, home_team_goal, away_team_goal, @home_player_1, @home_player_2, @home_player_3, @home_player_4, @home_player_5, @home_player_6, @home_player_7, @home_player_8, @home_player_9, @home_player_10, @home_player_11, @away_player_1, @away_player_2, @away_player_3, @away_player_4, @away_player_5, @away_player_6, @away_player_7, @away_player_8, @away_player_9, @away_player_10, @away_player_11)

SET home_player_1 = nullif(@home_player_1, '')
	,home_player_2 = nullif(@home_player_2, '')
	,home_player_3 = nullif(@home_player_3, '')
	,home_player_4 = nullif(@home_player_4, '')
	,home_player_5 = nullif(@home_player_5, '')
	,home_player_6 = nullif(@home_player_6, '')
	,home_player_7 = nullif(@home_player_7, '')
	,home_player_8 = nullif(@home_player_8, '')
	,home_player_9 = nullif(@home_player_9, '')
	,home_player_10 = nullif(@home_player_10, '')
	,home_player_11 = nullif(@home_player_11, '')
	,away_player_1 = nullif(@away_player_1, '')
	,away_player_2 = nullif(@away_player_2, '')
	,away_player_3 = nullif(@away_player_3, '')
	,away_player_4 = nullif(@away_player_4, '')
	,away_player_5 = nullif(@away_player_5, '')
	,away_player_6 = nullif(@away_player_6, '')
	,away_player_7 = nullif(@away_player_7, '')
	,away_player_8 = nullif(@away_player_8, '')
	,away_player_9 = nullif(@away_player_9, '')
	,away_player_10 = nullif(@away_player_10, '')
	,away_player_11 = nullif(@away_player_11, '');

DROP TABLE

IF EXISTS team_attributes;
	CREATE TABLE team_attributes (
		id INTEGER NOT NULL
		,team_fifa_api_id INT
		,team_api_id INT NOT NULL
		,team_date DATE
		,buildUpPlaySpeed TINYINT
		,buildUpPlaySpeedClass VARCHAR(20)
		,buildUpPlayDribbling TINYINT
		,buildUpPlayDribblingClass VARCHAR(20)
		,buildUpPlayPassing TINYINT
		,buildUpPlayPassingClass VARCHAR(20)
		,buildUpPlayPositioningClass VARCHAR(20)
		,chanceCreationPassing TINYINT
		,chanceCreationPassingClass VARCHAR(20)
		,chanceCreationCrossing TINYINT
		,chanceCreationCrossingClass VARCHAR(20)
		,chanceCreationShooting TINYINT
		,chanceCreationShootingClass VARCHAR(20)
		,chanceCreationPositioningClass VARCHAR(20)
		,defencePressure TINYINT
		,defencePressureClass VARCHAR(20)
		,defenceAggression TINYINT
		,defenceAggressionClass VARCHAR(20)
		,defenceTeamWidth TINYINT
		,defenceTeamWidthClass VARCHAR(20)
		,defenceDefenderLineClass VARCHAR(20)
		,PRIMARY KEY (id)
		,KEY team_api_id(team_api_id)
		,CONSTRAINT team_attributes_ibfk_1 FOREIGN KEY (team_api_id) REFERENCES teams(team_api_id)
		);

LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/team_attributes.csv'
INTO TABLE team_attributes CHARACTER

SET CP1250 FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' ignore 1 rows(id, team_fifa_api_id, team_api_id, team_date, buildUpPlaySpeed, buildUpPlaySpeedClass, @buildUpPlayDribbling, buildUpPlayDribblingClass, buildUpPlayPassing, buildUpPlayPassingClass, buildUpPlayPositioningClass, chanceCreationPassing, chanceCreationPassingClass, chanceCreationCrossing, chanceCreationCrossingClass, chanceCreationShooting, chanceCreationShootingClass, chanceCreationPositioningClass, defencePressure, defencePressureClass, defenceAggression, defenceAggressionClass, defenceTeamWidth, defenceTeamWidthClass, defenceDefenderLineClass)
SET buildUpPlayDribbling = nullif(@buildUpPlayDribbling, 'NA');


DROP TABLE

IF EXISTS player_attributes;
	CREATE TABLE player_attributes (
		player_attribute_id INT
		,player_fifa_api_id INT
		,player_api_id INT
		,player_date DATE
		,overall_rating TINYINT
		,potential TINYINT
		,preferred_foot VARCHAR(10)
		,attacking_work_rate VARCHAR(10)
		,defensive_work_rate VARCHAR(10)
		,crossing TINYINT
		,finishing TINYINT
		,heading_accuracy TINYINT
		,short_passing TINYINT
		,volleys TINYINT
		,dribbling TINYINT
		,curve TINYINT
		,free_kick_accuracy TINYINT
		,long_passing TINYINT
		,ball_control TINYINT
		,acceleration TINYINT
		,sprint_speed TINYINT
		,agility TINYINT
		,reactions TINYINT
		,balance TINYINT
		,shot_power TINYINT
		,jumping TINYINT
		,stamina TINYINT
		,strength TINYINT
		,long_shots TINYINT
		,aggression TINYINT
		,interceptions TINYINT
		,positioning TINYINT
		,vision TINYINT
		,penalties TINYINT
		,marking TINYINT
		,standing_tackle TINYINT
		,sliding_tackle TINYINT
		,gk_diving TINYINT
		,gk_handling TINYINT
		,gk_kicking TINYINT
		,gk_positioning TINYINT
		,gk_reflexes TINYINT
		,PRIMARY KEY (player_attribute_id)
		,KEY player_api_id(player_api_id)
		,CONSTRAINT player_attributes_ibfk_1 FOREIGN KEY (player_api_id) REFERENCES players(player_api_id)
		);

LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/player_attributes.csv'
INTO TABLE player_attributes CHARACTER

SET CP1250 FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' ignore 1 rows(player_attribute_id, @player_fifa_api_id, player_api_id, player_date, @overall_rating, @potential, @preferred_foot, attacking_work_rate, defensive_work_rate, @crossing, @finishing, @heading_accuracy, @short_passing, @volleys, @dribbling, @curve, @free_kick_accuracy, @long_passing, @ball_control, @acceleration, @sprint_speed, @agility, @reactions, @balance, @shot_power, @jumping, @stamina, @strength, @long_shots, @aggression, @interceptions, @positioning, @vision, @penalties, @marking, @standing_tackle, @sliding_tackle, @gk_diving, @gk_handling, @gk_kicking, @gk_positioning, @gk_reflexes)
SET player_fifa_api_id = nullif(@player_fifa_api_id, 'NA')
	,overall_rating = nullif(@overall_rating, 'NA')
	,potential = nullif(@potential, 'NA')
	,preferred_foot = nullif(@preferred_foot, 'NA')
	,crossing = nullif(@crossing, 'NA')
	,finishing = nullif(@finishing, 'NA')
	,heading_accuracy = nullif(@heading_accuracy, 'NA')
	,short_passing = nullif(@short_passing, 'NA')
	,volleys = nullif(@volleys, 'NA')
	,dribbling = nullif(@dribbling, 'NA')
	,curve = nullif(@curve, 'NA')
	,free_kick_accuracy = nullif(@free_kick_accuracy, 'NA')
	,long_passing = nullif(@long_passing, 'NA')
	,ball_control = nullif(@ball_control, 'NA')
	,acceleration = nullif(@acceleration, 'NA')
	,sprint_speed = nullif(@sprint_speed, 'NA')
	,agility = nullif(@agility, 'NA')
	,reactions = nullif(@reactions, 'NA')
	,balance = nullif(@balance, 'NA')
	,shot_power = nullif(@shot_power, 'NA')
	,jumping = nullif(@jumping, 'NA')
	,stamina = nullif(@stamina, 'NA')
	,strength = nullif(@strength, 'NA')
	,long_shots = nullif(@long_shots, 'NA')
	,aggression = nullif(@aggression, 'NA')
	,interceptions = nullif(@interceptions, 'NA')
	,positioning = nullif(@positioning, 'NA')
	,vision = nullif(@vision, 'NA')
	,penalties = nullif(@penalties, 'NA')
	,marking = nullif(@marking, 'NA')
	,standing_tackle = nullif(@standing_tackle, 'NA')
	,sliding_tackle = nullif(@sliding_tackle, 'NA')
	,gk_diving = nullif(@gk_diving, 'NA')
	,gk_handling = nullif(@gk_handling, 'NA')
	,gk_kicking = nullif(@gk_kicking, 'NA')
	,gk_positioning = nullif(@gk_positioning, 'NA')
	,gk_reflexes = nullif(@gk_reflexes, 'NA');