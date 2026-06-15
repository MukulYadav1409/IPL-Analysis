USE ipl_analysis;

SELECT 
batter,
COUNT(DISTINCT match_id) as total_matches_played,
SUM(batsman_runs) as total_runs,
ROUND( SUM(batsman_runs) / COUNT(DISTINCT match_id), 2) as avg_runs_per_match
FROM deliveries
GROUP BY batter
ORDER BY total_runs DESC;


WITH season_runs AS (
    SELECT 
        d.batter,
        m.season,
        SUM(d.batsman_runs) AS runs_in_season
    FROM deliveries d
    JOIN matches m ON d.match_id = m.match_id
    GROUP BY d.batter, m.season
)

-- SELECT * FROM season_runs;

SELECT 
    batter,
    COUNT(season) AS seasons_played,
    SUM(runs_in_season) AS total_runs,
    ROUND(AVG(runs_in_season), 2) AS avg_runs_per_season
FROM season_runs
GROUP BY batter
HAVING seasons_played >= 3
ORDER BY avg_runs_per_season DESC
LIMIT 15;

-- ANSWER 11
-- Virat Kohli leads among high-volume batsmen with 471 avg runs per season across 17 seasons — the most consistent performer in 
-- IPL history by this metric. DA Warner (437) and KL Rahul (426) show strong consistency despite fewer seasons. Ruturaj Gaikwad 
-- tops the average at 476 but across only 5 seasons — impressive but less proven over time. Shubman Gill at 459 across 7 seasons signals
-- he is emerging as one of the most reliable batsmen of the current era.