USE ipl_analysis;

WITH home_teams AS (
    SELECT match_id, city, team1, team2, winner,
        CASE 
            WHEN city = 'Mumbai' THEN 'Mumbai Indians'
            WHEN city = 'Kolkata' THEN 'Kolkata Knight Riders'
            WHEN city = 'Delhi' THEN 'Delhi Capitals'
            WHEN city = 'Chennai' THEN 'Chennai Super Kings'
            WHEN city = 'Bangalore' THEN 'Royal Challengers Bangalore'
            WHEN city = 'Hyderabad' THEN 'Sunrisers Hyderabad'
            WHEN city = 'Mohali' OR city = 'Chandigarh' THEN 'Kings XI Punjab'
            WHEN city = 'Jaipur' THEN 'Rajasthan Royals'
            WHEN city = 'Pune' THEN 'Rising Pune Supergiant'
            WHEN city = 'Visakhapatnam' THEN 'Sunrisers Hyderabad'
        END AS home_team
    FROM matches
)

SELECT 
	home_team,
	COUNT(*) as home_matches,
    SUM(CASE WHEN winner = home_team THEN 1 ELSE 0 END) as home_wins,
    ROUND(SUM(CASE WHEN winner = home_team THEN 1 ELSE 0 END) / COUNT(*)  * 100 , 2) as win_percentage
FROM home_teams
WHERE home_team IS NOT NULL
GROUP BY home_team
ORDER BY win_percentage DESC;
	
-- Answer 2
-- Home ground is approximated by mapping each IPL franchise to its primary city. This means all matches played in that city 
-- — including neutral venue playoff games and matches involving other teams — are counted as "home matches." 
-- As a result, match counts may be inflated for certain franchises, particularly those based in major host cities like Mumbai and Delhi. 
-- This analysis should be treated as directional rather than definitive. Official home ground designation data is not available in this dataset.
