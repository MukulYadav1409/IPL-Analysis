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
HAVING matches_played > 5
ORDER BY runs_per_wicket DESC;

-- Answer 1
-- Observation: Based on average runs per match and runs per wicket ratio, stadiums can be classified into batter-friendly and bowler-friendly 
-- categories. Rajiv Gandhi International Stadium (Hyderabad) and Arun Jaitley Stadium (Delhi) emerge as the most batter-friendly venues with 
-- the highest runs per wicket ratios, meaning batters score freely and wickets are harder to come by. On the other hand, 
-- Himachal Pradesh Cricket Association Stadium (Dharamsala) and Dr. YSR ACA-VDCA Stadium (Visakhapatnam) favor bowlers, with lower runs per 
-- wicket ratios indicating wickets fall more frequently relative to runs scored. M Chinnaswamy Stadium (Bengaluru), despite its reputation as a 
-- high-scoring ground, sits in the middle range — high average runs but also high wickets, suggesting both batters and bowlers 
-- find opportunity there.
-- Note: Analysis is based on matches with a minimum of 5 games played at the venue to ensure statistical reliability. 
-- Venues with fewer matches are excluded to avoid skewed results.

