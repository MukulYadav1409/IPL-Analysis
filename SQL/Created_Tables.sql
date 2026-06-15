-- CREATE DATABASE ipl_analysis;
USE ipl_analysis;

CREATE TABLE matches (
    match_id INT PRIMARY KEY,
    season VARCHAR(10),
    city VARCHAR(50),
    date VARCHAR(20),
    match_type VARCHAR(20),
    player_of_match VARCHAR(50),
    venue VARCHAR(100),
    team1 VARCHAR(50),
    team2 VARCHAR(50),
    toss_winner VARCHAR(50),
    toss_decision VARCHAR(10),
    winner VARCHAR(50),
    result VARCHAR(20),
    result_margin INT,
    target_runs INT,
    target_overs FLOAT,
    super_over VARCHAR(5),
    method VARCHAR(10),
    umpire1 VARCHAR(50),
    umpire2 VARCHAR(50)
);

CREATE TABLE deliveries (
    match_id INT,
    inning INT,
    batting_team VARCHAR(50),
    bowling_team VARCHAR(50),
    overs INT,
    ball INT,
    batter VARCHAR(50),
    bowler VARCHAR(50),
    non_striker VARCHAR(50),
    batsman_runs INT,
    extra_runs INT,
    total_runs INT,
    extras_type VARCHAR(20),
    is_wicket INT,
    player_dismissed VARCHAR(50),
    dismissal_kind VARCHAR(30),
    fielder VARCHAR(50),
    FOREIGN KEY (match_id) REFERENCES matches(match_id)
);