Drop view if exists Reporting_view;

Create view Reporting_view AS 

SELECT f.country_name
	,f.league_name
	,f.season
	,f.team_long_name
	,round((avg(f.team_defence_aggression) + avg(f.team_defence_pressure) + avg(f.team_defence_width)) / 3, 2) AS Defence_Stats
	,round((avg(f.team_chancecreation_crossing) + avg(f.team_chancecreation_passing) + avg(f.team_chancecreation_shooting)) / 3, 2) AS Attack_Stats
	,round((avg(f.team_buildup_passing) + avg(f.team_buildup_speed)) / 2, 2) AS Midfield_Stats
	,round((avg(finishing) + avg(heading_accuracy) + avg(volleys) + avg(dribbling) + avg(acceleration) + avg(sprint_speed) + avg(shot_power) + avg(jumping) + avg(strength) + avg(long_shots)) / 10, 2) AS Player_Attack
	,round((avg(reactions) + avg(balance) + avg(stamina) + avg(aggression) + avg(interceptions) + avg(positioning) + avg(marking) + avg(standing_tackle) + avg(sliding_tackle)) / 9, 2) AS Player_Defense
	,round((avg(crossing) + avg(short_passing) + avg(curve) + avg(free_kick_accuracy) + avg(long_passing) + avg(ball_control) + avg(agility) + avg(vision) + avg(penalties)) / 9, 2) AS Player_Midfield
	,round((avg(gk_diving) + avg(gk_handling) + avg(gk_kicking) + avg(gk_positioning) + avg(gk_reflexes)) / 5, 2) AS Player_Goalkeeper
FROM dw_football f
GROUP BY f.country_name
	,f.league_name
	,f.season
	,f.team_long_name;

-------

Drop view if exists Scounting_view;

Create view Scounting_view AS 

SELECT  f.player_name
	,f.season
	,f.weight
	,f.height
	,f.birthday
	,round(DATE - year(birthday), 0) AS Age
	,f.team_long_name
	,f.preferred_foot
	,round((avg(f.overall_rating)), 2) AS overall_rating
	,round((avg(f.potential)), 2) AS potential
	,round((avg(finishing) + avg(heading_accuracy) + avg(volleys) + avg(dribbling) + avg(acceleration) + avg(sprint_speed) + avg(shot_power) + avg(jumping) + avg(strength) + avg(long_shots)) / 10, 2) AS Attack_Skills
	,round((avg(reactions) + avg(balance) + avg(stamina) + avg(aggression) + avg(interceptions) + avg(positioning) + avg(marking) + avg(standing_tackle) + avg(sliding_tackle)) / 9, 2) AS Defense_Skills
	,round((avg(crossing) + avg(short_passing) + avg(curve) + avg(free_kick_accuracy) + avg(long_passing) + avg(ball_control) + avg(agility) + avg(vision) + avg(penalties)) / 9, 2) AS Midfield_Skills
	,round((avg(gk_diving) + avg(gk_handling) + avg(gk_kicking) + avg(gk_positioning) + avg(gk_reflexes)) / 5, 2) AS Goalkeeper_Skills
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
FROM dw_football f
GROUP BY f.player_name
	,f.season
	,f.weight
	,f.height
	,f.birthday
	,round(DATE - year(birthday), 0)
	,f.team_long_name
	,f.preferred_foot;

