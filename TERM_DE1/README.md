# Submission - European Soccer dataset #

This folder contains all my workfiles used for the [term project](https://github.com/salacika/DE1SQL/tree/master/SQL6#homework) in Data Engineering 1. I set out to build a MySQL schema using the **European Soccer dataset** available on Kaggle - [link](https://www.kaggle.com/hugomathien/soccer/home).

Markdown cheatsheet: https://github.com/tchapi/markdown-cheatsheet/blob/master/README.md

###  Operational layer ###


My operational layer consists of 7 tables - all centered around football matches that happened in years: 2003-2010. The below EER diagrams were generated from MySQL - I needed to split my tables to two categories otherwise MySQL crashed due to the high number of columns available in one of my tables. 

1.  Matches in relation to football teams, leagues and the name of the country to which these entities might belong. 
    ![Database diagram](/TERM_DE1/EER_diagramm_without_players.png)