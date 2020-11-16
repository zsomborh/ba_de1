# Submission - European Soccer dataset #

This folder contains all my workfiles used for the [term project](https://github.com/salacika/DE1SQL/tree/master/SQL6#homework) in Data Engineering 1. I set out to build a MySQL schema using the **European Soccer dataset** available on Kaggle - [link](https://www.kaggle.com/hugomathien/soccer/home).

### Task interpretation ###

I was hired by a football club with a lack of success in recent years. The board decided to invest a lot of money with the goal of finding talented players that could help the team reach it's prior glory and they decided that statistics is the way to go. They acquired a huge bulk of data to support their analytics teams currently employed by the club, but they are missing a central database to store this data. They gave me the task to design a system and provide high quality, easily interpretable data to the following three analytical groups:
 - the first one is a scouting unit that looks at the raw skills of players (e.g. how good are they with headers, acceleration, shot power)
 - the second looks at player development to further predict their potential
 - the third is responsible to create reports and visualisations to the board. Their need is to have a simple structure with diverse dimensions (name of the teams, the league and country in which they play etc...). However they should not be allowed to see player level data, only attributes due to security concerns.

I decided to implement the solution in an RDBMS engine -  MySQL.

###  Operational layer ###

My operational layer consists of [7 tables stored in csv](/TERM_DE1/data) - all centered around football matches that happened in years: 2008-2016. The below EER diagrams represent this star schema with **matches** table in the center as my fact table. The reason why I have two diagrams is due to MySQL crashing when I tried to reverse engineer the EERs for all tables, which is probably the result of the high number of columns + primary & foreign key pairs available in my tables. 

1.  First diagramm: football matches in relation to teams, leagues and the name of the country to which these entities belong:
    * In the **matches** table, every observation is a football match between two teams 
    * **league** table contains the name of 11 European first class soccer leagues
    * **country** table helps identify the name of a Country based on country id in other tables 
    * The **teams** table contains the long and short name of teams
    * **team attributes** table contains a lot of qualitative and quantitative feature of a team in a given date

![Database diagram](/TERM_DE1/EER_diagramm_without_players.png)

2.  Second diagram: Players that played in given matches and their attributes:  
    * **players** table contains the birthday, weight and height of a player 
    * **player_attributes** table shows qualitative and quantitative attributes of given player for a given date
    
![Database diagram](/TERM_DE1/EER_diagramm_players_only.png)

There are two issues with the data which I will have to address when creating my data warehouse. Firstly, there are missing values in the tables which is an issue not only for missing attributes but also for missing IDs - this is due to the deficiencies of the data collection process and data availability as described in [Kaggle](https://www.kaggle.com/hugomathien/soccer/home). Secondly, there is no direct link between teams and players - they are connected only by the **matches** table. Moreover players connection to the matches is a bit tricky - for each row in the **matches** table there are 22 players IDs that can serve as a foreign key when linking this table with the **players** table.

Operational layer was created using the following [queries](/TERM_DE1/Assignment-Operational_layer.sql).

###  Analytics plan ###

My analytics plan is the following:
1. Loading up the acquired data
2. Create ETL pipeline to create a denormalised data warehouse 
3. Create ETL pipeline to create data marts for the three analytical teams

This is illustrated in the below figure: 

![Analytics plan diagram](/TERM_DE1/ETL_to_create_dw.sql)

###  Analytical layer ###
 
In the analytical layer I created one central denormalised data warehouse with a player in each observation in a given year. Firstly, I transposed all 12 home player columns into rows in the matches table - this way the granularity of the table was changed to players instead of matches. I used home players and home teams only to reduce complexity, but with this I sacrificed information such as the outcome of given match which is not a huge issue since it's unnecessary in the context of the task. Secondly, I joined the other tables with leage, country, team and player information, paying extra care to dates, when the table had a date dimension. Every observation where player ID was not available, was dropped. To reduce the complexity of data, I omitted the month and day information in any available date and joined based on *Year* information only. If I had more than one observation in a year for a given entity, I used the average of quantitative variables (the only table that required such a transformation was the **player_attributes** table). The below figure gives a glimpse of the information stored in the data warehouse. 

Analytical layer was created using the following [queries](/TERM_DE1/analytics_plan.PNG).

![DW diagram](/TERM_DE1/analytics_plan.png)

###  Data Mart ###
 
I created three data marts for the analytical teams, which are the following: 
 
##### Reporting_view #####

In this view the users can see the names of the teams, the leagues in which they play and some aggregate quantitative performance metrics about the teams and the players in a given team. I took the average of performance indicators over a given season as it could happen that a team/player was measured mutliple times in a given year. This view is excellent to provide visual elements in terms of geography, league participation (e.g. which teams dropped out of given league from one season to another) and to give a high level view of team and player performance. I also created this view in a way that no individual player record is available so that no sensitive information can be leaked. It can happen that the duties of this team will be outsourced to a third party, hence it is better to protect this data. 

##### Scouting_view #####

The goal of this view is to show the average of raw skills/statistics and some demographic variables of a given player in a given season. I transformed their birthday to see the age of the player in a given season (it is a simplified Age variable, as it is only the difference between two Years averaged out over the season). This view will be used by the scouting units who want to find talented young players or look for a player that excels at a given set of skills (e.g. fast, and good at finishing). I also included a variable that averages out the skills that are best used for attacking, defending, midfield and goalkeepers, as this can indicate the position where given player can play. 

##### Player_development_view #####

The player development team will work closely with the scouting unit to flag players that might not be very highly rated now, but there is a lot of potential coming from the growth of their skills. I use the overall_rating in the data warehouse and transpose this variable so that it is shown in a different column for each season. In order to do so, I used left outer joins in the same table (craeting a self join).

I created the **Player_development** materialised view first and built the **Player_development_view** based on that. This is to cater for a scenario when more data is received in the future for more seasons. Due to the high number of left outer joins, creating this view is quite computational heavy already, so later on a separate stored procedure might be required to create the materialised view first, and build the final data mart later. Right now, both of these are created in the data mart ETL. 

Data marts were created using the following [queries](/TERM_DE1/ETL_to_create_data_mart.sql).