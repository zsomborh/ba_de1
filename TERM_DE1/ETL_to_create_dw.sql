use assignment_football;

drop procedure if exists ETL_Data_Warehouse; 

DELIMITER $$ 

Create procedure ETL_Data_Warehouse()

BEGIN

Drop table if exists dw_football;

create table dw_football as 

SELECT DISTINCT lc.country_name
	,lc.league_name
	,t.team_long_name
	,t.team_short_name
	,left(m.match_date,4) as Date
	,m.season
	,p.birthday
	,p.height
	,p.weight
	,p.player_name
	,ta.buildUpPlaySpeed as team_buildup_speed
	,ta.buildUpPlayPassing as team_buildup_passing 
	,ta.chanceCreationPassing as team_chancecreation_passing
	,ta.chanceCreationCrossing as team_chancecreation_crossing
	,ta.chanceCreationShooting as team_chancecreation_shooting
	,ta.defencePressure as team_defence_pressure 
	,ta.defenceAggression as team_defence_aggression
	,ta.defenceTeamWidth as team_defence_width
	,pa.crossing
	,pa.finishing
	,pa.heading_accuracy
	,pa.short_passing
	,pa.volleys
	,pa.dribbling
	,pa.curve
	,pa.free_kick_accuracy
	,pa.long_passing
	,pa.ball_control
	,pa.acceleration
	,pa.sprint_speed
	,pa.agility
	,pa.reactions
	,pa.balance
	,pa.shot_power
	,pa.jumping
	,pa.stamina
	,pa.strength
	,pa.long_shots
	,pa.aggression
	,pa.interceptions
	,pa.positioning
	,pa.vision
	,pa.penalties
	,pa.marking
	,pa.standing_tackle
	,pa.sliding_tackle
	,pa.gk_diving
	,pa.gk_handling
	,pa.gk_kicking
	,pa.gk_positioning
	,pa.gk_reflexes
	,pa.overall_rating
	,pa.potential
	,pa.preferred_foot
FROM (
	SELECT country_id
		,league_id
		,match_date
		,home_team_goal
		,away_team_goal
		,season
		,home_team_api_id
		,away_team_api_id
		,home_player_1 AS player
		,'home_player' AS player_affiliation
	FROM matches
	
	UNION ALL
	
	SELECT country_id
		,league_id
		,match_date
		,home_team_goal
		,away_team_goal
		,season
		,home_team_api_id
		,away_team_api_id
		,home_player_2 AS player
		,'home_player' AS player_affiliation
	FROM matches
	
	UNION ALL
	
	SELECT country_id
		,league_id
		,match_date
		,home_team_goal
		,away_team_goal
		,season
		,home_team_api_id
		,away_team_api_id
		,home_player_3 AS player
		,'home_player' AS player_affiliation
	FROM matches
	
	UNION ALL
	
	SELECT country_id
		,league_id
		,match_date
		,home_team_goal
		,away_team_goal
		,season
		,home_team_api_id
		,away_team_api_id
		,home_player_4 AS player
		,'home_player' AS player_affiliation
	FROM matches
	
	UNION ALL
	
	SELECT country_id
		,league_id
		,match_date
		,home_team_goal
		,away_team_goal
		,season
		,home_team_api_id
		,away_team_api_id
		,home_player_5 AS player
		,'home_player' AS player_affiliation
	FROM matches
	
	UNION ALL
	
	SELECT country_id
		,league_id
		,match_date
		,home_team_goal
		,away_team_goal
		,season
		,home_team_api_id
		,away_team_api_id
		,home_player_6 AS player
		,'home_player' AS player_affiliation
	FROM matches
	
	UNION ALL
	
	SELECT country_id
		,league_id
		,match_date
		,home_team_goal
		,away_team_goal
		,season
		,home_team_api_id
		,away_team_api_id
		,home_player_7 AS player
		,'home_player' AS player_affiliation
	FROM matches
	
	UNION ALL
	
	SELECT country_id
		,league_id
		,match_date
		,home_team_goal
		,away_team_goal
		,season
		,home_team_api_id
		,away_team_api_id
		,home_player_8 AS player
		,'home_player' AS player_affiliation
	FROM matches
	
	UNION ALL
	
	SELECT country_id
		,league_id
		,match_date
		,home_team_goal
		,away_team_goal
		,season
		,home_team_api_id
		,away_team_api_id
		,home_player_9 AS player
		,'home_player' AS player_affiliation
	FROM matches
	
	UNION ALL
	
	SELECT country_id
		,league_id
		,match_date
		,home_team_goal
		,away_team_goal
		,season
		,home_team_api_id
		,away_team_api_id
		,home_player_10 AS player
		,'home_player' AS player_affiliation
	FROM matches
	
	UNION ALL
	
	SELECT country_id
		,league_id
		,match_date
		,home_team_goal
		,away_team_goal
		,season
		,home_team_api_id
		,away_team_api_id
		,home_player_11 AS player
		,'home_player' AS player_affiliation
	FROM matches
	) m
LEFT JOIN (
	SELECT l.league_id
		,c.country_id
		,l.league_name
		,c.country_name
	FROM league l
	INNER JOIN country c ON c.country_id = l.country_id
	) lc ON m.country_id = lc.country_id
	AND m.league_id = lc.league_id
INNER JOIN teams t ON t.team_api_id = m.home_team_api_id
INNER JOIN players p ON m.player = p.player_api_id
LEFT JOIN team_attributes ta ON left(ta.team_date, 4) = left(m.match_date, 4)
	AND ta.team_api_id = home_team_api_id
LEFT JOIN (
	SELECT player_date AS player_date
		,preferred_foot
		,player_api_id
		,avg(overall_rating) AS overall_rating
		,avg(potential) AS potential
		,avg(crossing) AS crossing
		,avg(finishing) AS finishing
		,avg(heading_accuracy) AS heading_accuracy
		,avg(short_passing) AS short_passing
		,avg(volleys) AS volleys
		,avg(dribbling) AS dribbling
		,avg(curve) AS curve
		,avg(free_kick_accuracy) AS free_kick_accuracy
		,avg(long_passing) AS long_passing
		,avg(ball_control) AS ball_control
		,avg(acceleration) AS acceleration
		,avg(sprint_speed) AS sprint_speed
		,avg(agility) AS agility
		,avg(reactions) AS reactions
		,avg(balance) AS balance
		,avg(shot_power) AS shot_power
		,avg(jumping) AS jumping
		,avg(stamina) AS stamina
		,avg(strength) AS strength
		,avg(long_shots) AS long_shots
		,avg(aggression) AS aggression
		,avg(interceptions) AS interceptions
		,avg(positioning) AS positioning
		,avg(vision) AS vision
		,avg(penalties) AS penalties
		,avg(marking) AS marking
		,avg(standing_tackle) AS standing_tackle
		,avg(sliding_tackle) AS sliding_tackle
		,avg(gk_diving) AS gk_diving
		,avg(gk_handling) AS gk_handling
		,avg(gk_kicking) AS gk_kicking
		,avg(gk_positioning) AS gk_positioning
		,avg(gk_reflexes) AS gk_reflexes
	FROM player_attributes
	GROUP BY left(player_date, 4)
		,preferred_foot
		,player_api_id
	) pa ON left(pa.player_date, 4) = left(m.match_date, 4)
	AND pa.player_api_id = p.player_api_id
    order by left(m.match_date,4), p.player_name
    ;
    
    END $$
    
    DELIMITER ;
    
    Call ETL_Data_Warehouse();