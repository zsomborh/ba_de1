
--------
-- First I create the schema to work within 
-- 		Then I create the tables that will serve as the operational layer 
-- 		Data was downloaded from: https://www.kaggle.com/hugomathien/soccer
-------

drop schema if exists assignment_football;
create schema assignment_football;

use assignment_football;

drop table if exists country;

CREATE TABLE country 
(
country_id INTEGER NOT NULL,
country_name VARCHAR(255),
PRIMARY KEY(country_id));

LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/country.csv' 
INTO TABLE country
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n' 
ignore 1 rows
;

drop table if exists league;

CREATE TABLE league 
(
league_id INTEGER NOT NULL,
country_id integer,
league_name varchar(255),
PRIMARY KEY(league_id));

LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/league.csv' 
INTO TABLE league
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n' 
ignore 1 rows
;

drop table if exists matches;

CREATE TABLE matches 
(
match_id INTEGER NOT NULL,
country_id integer,
league_id integer,
season varchar (10), 
stage integer,
match_date  Date, 
match_api_id integer,
home_team_api_id integer,
away_team_api_id integer,
home_team_goal integer,
away_team_goal integer,
PRIMARY KEY(match_id));

LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/match.csv' 
INTO TABLE matches
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n' 
ignore 1 rows
;

drop table if exists teams;

CREATE TABLE teams 
(
team_id INTEGER NOT NULL,
team_api_id integer,
team_fifa_api_id  integer,
team_long_name varchar (255), 
team_short_name varchar(3), 
PRIMARY KEY(team_id));

LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/team.csv' 
INTO TABLE teams
CHARACTER SET CP1250
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n' 
ignore 1 rows
(team_id, team_api_id, @team_fifa_api_id, team_long_name, team_short_name)
SET
team_fifa_api_id = nullif(@team_fifa_api_id, 'NA')
;


drop table if exists team_attributes;

CREATE TABLE team_attributes (
team_id INTEGER NOT NULL,
team_fifa_api_id INT,
team_api_id INT,
team_date DATE,
buildUpPlaySpeed tinyint,
buildUpPlaySpeedClass VARCHAR(20),
buildUpPlayDribbling tinyint,
buildUpPlayDribblingClass VARCHAR(20),
buildUpPlayPassing tinyint,
buildUpPlayPassingClass VARCHAR(20),
buildUpPlayPositioningClass VARCHAR(20),
chanceCreationPassing tinyint,
chanceCreationPassingClass VARCHAR(20),
chanceCreationCrossing tinyint,
chanceCreationCrossingClass VARCHAR(20),
chanceCreationShooting tinyint,
chanceCreationShootingClass VARCHAR(20),
chanceCreationPositioningClass VARCHAR(20),
defencePressure tinyint,
defencePressureClass VARCHAR(20),
defenceAggression tinyint,
defenceAggressionClass VARCHAR(20),
defenceTeamWidth tinyint,
defenceTeamWidthClass VARCHAR(20),
defenceDefenderLineClass VARCHAR(20),
PRIMARY KEY(team_id));

LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/team_attributes.csv' 
INTO TABLE team_attributes
CHARACTER SET CP1250
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n' 
ignore 1 rows
(
team_id,
team_fifa_api_id,
team_api_id,
team_date,
buildUpPlaySpeed,
buildUpPlaySpeedClass,
@buildUpPlayDribbling,
buildUpPlayDribblingClass,
buildUpPlayPassing,
buildUpPlayPassingClass,
buildUpPlayPositioningClass,
chanceCreationPassing,
chanceCreationPassingClass,
chanceCreationCrossing,
chanceCreationCrossingClass,
chanceCreationShooting,
chanceCreationShootingClass,
chanceCreationPositioningClass,
defencePressure,
defencePressureClass,
defenceAggression,
defenceAggressionClass,
defenceTeamWidth,
defenceTeamWidthClass ,
defenceDefenderLineClass 
)
SET
buildUpPlayDribbling = nullif(@buildUpPlayDribbling, 'NA')
;

DROP TABLE IF EXISTS players;

CREATE TABLE players (
player_id int not null,
player_api_id int,
player_name varchar(255),
player_fifa_api_id int,
birthday date,
height double,
weight smallint, primary key(player_id));


LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/player.csv' 
INTO TABLE players
CHARACTER SET CP1250
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n' 
ignore 1 rows;


DROP TABLE IF EXISTS player_attributes;

CREATE TABLE player_attributes (
player_attribute_id int,
player_fifa_api_id int,
player_api_id int,
player_date date,
overall_rating tinyint,
potential tinyint,
preferred_foot varchar(10),
attacking_work_rate varchar (10),
defensive_work_rate varchar (10),
crossing tinyint,
finishing tinyint,
heading_accuracy tinyint,
short_passing tinyint,
volleys tinyint,
dribbling tinyint,
curve tinyint,
free_kick_accuracy tinyint,
long_passing tinyint,
ball_control tinyint,
acceleration tinyint,
sprint_speed tinyint,
agility tinyint,
reactions tinyint,
balance tinyint,
shot_power tinyint,
jumping tinyint,
stamina tinyint,
strength tinyint,
long_shots tinyint,
aggression tinyint,
interceptions tinyint,
positioning tinyint,
vision tinyint,
penalties tinyint,
marking tinyint,
standing_tackle tinyint,
sliding_tackle tinyint,
gk_diving tinyint,
gk_handling tinyint,
gk_kicking tinyint,
gk_positioning tinyint,
gk_reflexes tinyint,
primary key (player_attribute_id));

LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/player_attributes.csv' 
INTO TABLE player_attributes
CHARACTER SET CP1250
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n' 
ignore 1 rows
(player_attribute_id ,
@player_fifa_api_id ,
player_api_id ,
player_date ,
@overall_rating ,
@potential ,
@preferred_foot ,
attacking_work_rate ,
defensive_work_rate ,
@crossing ,
@finishing ,
@heading_accuracy ,
@short_passing ,
@volleys ,
@dribbling ,
@curve ,
@free_kick_accuracy ,
@long_passing ,
@ball_control ,
@acceleration ,
@sprint_speed ,
@agility ,
@reactions ,
@balance ,
@shot_power ,
@jumping ,
@stamina ,
@strength ,
@long_shots ,
@aggression ,
@interceptions ,
@positioning ,
@vision ,
@penalties ,
@marking ,
@standing_tackle ,
@sliding_tackle ,
@gk_diving ,
@gk_handling ,
@gk_kicking ,
@gk_positioning ,
@gk_reflexes
)
SET 
player_fifa_api_id = nullif(@player_fifa_api_id, 'NA'),
overall_rating = nullif(@overall_rating, 'NA'),
potential = nullif(@potential, 'NA'),
preferred_foot = nullif(@preferred_foot, 'NA'),
crossing = nullif(@crossing, 'NA'),
finishing = nullif(@finishing, 'NA'),
heading_accuracy = nullif(@heading_accuracy, 'NA'),
short_passing = nullif(@short_passing, 'NA'),
volleys = nullif(@volleys,'NA'),
dribbling = nullif(@dribbling,'NA'),
curve = nullif(@curve,'NA'),
free_kick_accuracy = nullif(@free_kick_accuracy,'NA'),
long_passing = nullif(@long_passing,'NA'),
ball_control = nullif(@ball_control,'NA'),
acceleration = nullif(@acceleration,'NA'),
sprint_speed = nullif(@sprint_speed,'NA'),
agility = nullif(@agility,'NA'),
reactions = nullif(@reactions,'NA'),
balance = nullif(@balance,'NA'),
shot_power = nullif(@shot_power,'NA'),
jumping = nullif(@jumping,'NA'),
stamina = nullif(@stamina,'NA'),
strength = nullif(@strength,'NA'),
long_shots = nullif(@long_shots,'NA'),
aggression = nullif(@aggression,'NA'),
interceptions = nullif(@interceptions,'NA'),
positioning = nullif(@positioning,'NA'),
vision = nullif(@vision,'NA'),
penalties = nullif(@penalties,'NA'),
marking = nullif(@marking,'NA'),
standing_tackle = nullif(@standing_tackle,'NA'),
sliding_tackle= nullif(@sliding_tackle,'NA'),
gk_diving = nullif(@gk_diving,'NA'),
gk_handling = nullif(@gk_handling,'NA'), 
gk_kicking= nullif(@gk_kicking,'NA'), 
gk_positioning= nullif(@gk_positioning,'NA'), 
gk_reflexes= nullif(@gk_reflexes,'NA')
;
