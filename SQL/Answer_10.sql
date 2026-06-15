USE ipl_analysis;

SELECT 
COUNT(DISTINCT match_id) as total_matches,
SUM( CASE WHEN batsman_runs = 6 THEN 1 ELSE 0 END) as total_sixes
FROM deliveries
WHERE overs BETWEEN 0 and 1;

SELECT 
    COUNT(DISTINCT match_id) AS matches_with_six_in_first_2_overs  -- this also counts sixes of super overs, as we havn't setted innings
FROM deliveries
WHERE overs BETWEEN 0 AND 1
AND batsman_runs = 6;

SELECT 
	COUNT(DISTINCT match_id) AS matches_with_six_in_first_2_overs,
    COUNT(DISTINCT CONCAT(match_id, '-', inning)) AS innings_with_six_in_first_2_overs
FROM deliveries								
WHERE overs BETWEEN 0 AND 1					-- ANSWER 10
AND batsman_runs = 6						-- 60 innings have got sixes in both innings in first 2 over
AND inning IN (1, 2);