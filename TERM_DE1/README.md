# Submission - European Soccer dataset #

This folder contains all my workfiles used for the [term project](https://github.com/salacika/DE1SQL/tree/master/SQL6#homework) in Data Engineering 1. I set out to build a MySQL schema using the **European Soccer dataset** available on Kaggle - [link](https://www.kaggle.com/hugomathien/soccer/home).

Markdown cheatsheet: https://github.com/tchapi/markdown-cheatsheet/blob/master/README.md

### Task interpretation ###

I was hired by a football club with a lack of success in recent years. The board decided to invest a lot of money with the goal of finding talented players that could help the team reach it's prior glory and they decided that statistics is the way to go. They acquired a huge bulk of data to support their analytics teams currently employed by the club, but they are missing a central database to store this data. They gave me the task to design a system and provide high quality, easily interpretable data to the following three analytical groups:
 - the first one looks at the raw skills of players (e.g. how good are they with headers, acceleration, shot power)
 - the second looks at player development to further predict their potential
 - the third is responsible to create reports and visualisations to the board. Their need is to have a simple structure with diverse dimensions (name of the teams, the league and country in which they play etc...)

I decided to implement the solution in an RDBMS engine -  MySQL.

###  Operational layer ###

My operational layer consists of [7 tables stored in csv](https://github.com/zsomborh/ba_de1/tree/master/TERM_DE1/data) - all centered around football matches that happened in years: 2008-2016. The below EER diagrams represent this star schema with **matches** table in the center as my fact table. The reason why I have two diagrams is due to MySQL crashing when I tried to reverse engineer the EERs for all tables, which is probably the result of the high number of columns + primary & foreign key pairs available in my tables. 

1.  First diagramm: matches in relation to football teams, leagues and the name of the country to which these entities belong:
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

There are two issues with the data which I will have to address when creating my data warehouse. Firstly, there are missing values in the tables which is an issue not only for missing attributes but also for missing IDs - this is due to the deficiencies of the data collection process as described in the [Kaggle link](https://www.kaggle.com/hugomathien/soccer/home). Secondly, there is no direct link between teams and players - they are connected only by the **matches** table. Moreover players connection to the matches is a bit tricky - for each row in the **matches** table there are 22 players IDs that can serve as a foreign key when linking this table with the **players** table.

Operational layer was created using the following queries [queries](/TERM_DE1/Assignment-Operational_layer.sql).

###  Analytics plan ###

My goal is twofold:

1. On the one hand, I need to load the acquired data, create a data warehouse extract while transforming data to be used by analytical teams
2. There are further plans to enrich this dataset with new entries. I was asked to automate this process in a way that if new data is added to the current tables, it shall update the data warehouse and data marts as well. Data will not be added regularly, but on an ad-hoc basis.   

I created two ETLs where the first enriches the data warehouse and the second creates each views. 

 ###  Analytical layer ###
 
In the analytical layer I created one central denormalised data warehouse with a player in each observation in a given year. Firstly, I transposed all 12 home player columns into rows in the matches table - this way the granularity of the table was changed to players instead of matches. I used home players and home teams only to reduce complexity, but with this I sacrificed information such as the outcome of given match as that is unnecessary in the context of the task. I then joined the other tables with leage, country, team and player information, paying extra care to dates, when the table had a date dimension. To reduce the complexity of data, I omitted the month and day information in any available date and joined based on *Year* information only. If I had more than one observation in a year for a given entity, I used the average of quantitative variables (the only table that required such a transformation was the **player_attributes** table). The below figure gives a glimpse of the information stored in the data warehouse. 

![DW diagram](/TERM_DE1/data_warehouse.PNG)