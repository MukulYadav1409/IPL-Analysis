USE ipl_analysis;

SELECT 
bowler,
COUNT(ball) as total_balls,
ROUND( COUNT(ball) / 6, 2) as total_overs,
COUNT(DISTINCT match_id) as total_matches_played,
ROUND( COUNT(ball) / COUNT(DISTINCT match_id), 2) as avg_balls_per_match,
SUM( CASE WHEN ball = '7' THEN 1 ELSE 0 END) as overs_exceeding_six_balls
FROM deliveries
GROUP BY bowler
ORDER BY overs_exceeding_six_balls DESC;

WITH balls_per_over AS (
    SELECT 
        match_id,
        inning,
        overs,
        bowler,
        COUNT(ball) AS ball_count
    FROM deliveries
    WHERE inning IN (1, 2)                          -- if we wanna remove the super overs for accurate data, if we want it than also we could keep 
    GROUP BY match_id, inning, overs, bowler		-- them, just the inning will be 3,4 as so on
)

-- SELECT * FROM balls_per_over;

SELECT 
    bowler,
    COUNT(*) AS times_bowled_extra_balls
FROM balls_per_over
WHERE ball_count > 6
GROUP BY bowler
ORDER BY times_bowled_extra_balls DESC
LIMIT 15;

-- ANSWER 14
-- Bowlers with the most overs exceeding 6 balls are generally high-volume bowlers like DJ Bravo, R Ashwin, and Malinga — 
-- indicating more extras bowled (wides/no-balls) correlates with workload rather than discipline issues alone.