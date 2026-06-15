USE ipl_analysis;

SELECT 
venue,
COUNT(DISTINCT m.match_id) as matches_played,
SUM(d.total_runs) / COUNT(DISTINCT m.match_id) AS avg_runs,
SUM(d.is_wicket) / COUNT(DISTINCT m.match_id) AS avg_wickets, 
SUM(d.total_runs) / SUM(d.is_wicket) AS runs_per_wicket        
FROM matches m
JOIN deliveries d ON m.match_id = d.match_id
GROUP BY venue
ORDER BY runs_per_wicket DESC;

