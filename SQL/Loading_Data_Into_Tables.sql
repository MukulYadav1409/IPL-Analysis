USE ipl_analysis;

LOAD DATA LOCAL INFILE 'C:/Users/mukul/Documents/Data Analytics/Projects/IPL Analysis/matches.csv'
INTO TABLE matches
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/mukul/Documents/Data Analytics/Projects/IPL Analysis/deliveries.csv'
INTO TABLE deliveries
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;