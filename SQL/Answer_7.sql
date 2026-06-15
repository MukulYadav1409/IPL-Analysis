USE ipl_analysis;

WITH clean_venues AS (
    SELECT *,
        CASE
            WHEN venue LIKE '%Chinnaswamy%' THEN 'M Chinnaswamy Stadium, Bengaluru'
            WHEN venue LIKE '%Wankhede%' THEN 'Wankhede Stadium, Mumbai'
            WHEN venue LIKE '%Eden Gardens%' THEN 'Eden Gardens, Kolkata'
            WHEN venue LIKE '%Brabourne%' THEN 'Brabourne Stadium, Mumbai'
            WHEN venue LIKE '%Arun Jaitley%' THEN 'Arun Jaitley Stadium, Delhi'
            WHEN venue LIKE '%Feroz Shah Kotla%' THEN 'Arun Jaitley Stadium, Delhi'
            WHEN venue LIKE '%DY Patil%' THEN 'Dr DY Patil Sports Academy, Mumbai'
            WHEN venue LIKE '%Rajiv Gandhi%' THEN 'Rajiv Gandhi International Stadium, Hyderabad'
            WHEN venue LIKE '%Punjab Cricket Association%' THEN 'Punjab Cricket Association Stadium, Mohali'
            WHEN venue LIKE '%Sawai Mansingh%' THEN 'Sawai Mansingh Stadium, Jaipur'
            WHEN venue LIKE '%MA Chidambaram%' THEN 'MA Chidambaram Stadium, Chepauk, Chennai'
            WHEN venue LIKE '%Maharashtra Cricket Association%' THEN 'Maharashtra Cricket Association Stadium, Pune'
            WHEN venue LIKE '%Himachal Pradesh%' THEN 'Himachal Pradesh Cricket Association Stadium, Dharamsala'
            WHEN venue LIKE '%Narendra Modi%' THEN 'Narendra Modi Stadium, Ahmedabad'
            WHEN venue LIKE '%Sardar Patel%' THEN 'Narendra Modi Stadium, Ahmedabad'
            WHEN venue LIKE '%Subrata Roy Sahara%' THEN 'Maharashtra Cricket Association Stadium, Pune'
            WHEN venue LIKE '%YSR%' OR venue LIKE '%Rajasekhara%' THEN 'Dr YSR ACA-VDCA Stadium, Visakhapatnam'
            WHEN venue LIKE '%Holkar%' THEN 'Holkar Cricket Stadium, Indore'
            WHEN venue LIKE '%Zayed%' OR venue LIKE '%Sheikh Zayed%' THEN 'Sheikh Zayed Stadium, Abu Dhabi'
            ELSE venue
        END AS clean_venue
    FROM matches
)

-- WITH overs_distribution AS(
-- 	SELECT * ,
--     CASE 
-- 		WHEN overs BETWEEN 0 AND 5 THEN "Power_Play"
--         WHEN overs BETWEEN 6 and 14 THEN "Middle_Overs"
--         WHEN overs BETWEEN 15 and 19 THEN "Death_Overs"
-- 	END AS overs_category
--     FROM deliveries
--     WHERE overs BETWEEN 0 AND 5
-- )

SELECT 
clean_venue,
COUNT(DISTINCT cv.match_id) as matches_played,
SUM(CASE WHEN overs BETWEEN 0 and 5 THEN d.total_runs ELSE 0 END) as power_play_runs,
SUM(CASE WHEN (is_wicket = 1) AND (overs BETWEEN 0 and 5) THEN 1 ELSE 0 END) as total_wickets_in_powerplay,
ROUND( SUM(CASE WHEN overs BETWEEN 0 and 5 THEN d.batsman_runs ELSE 0 END) / COUNT(DISTINCT cv.match_id), 2) as avg_runs_powerplay,
ROUND( SUM(CASE WHEN (is_wicket = 1) AND (overs BETWEEN 0 and 5) THEN 1 ELSE 0 END) / COUNT(DISTINCT cv.match_id), 2) as avg_wickets_powerplay
FROM clean_venues cv
JOIN deliveries d ON cv.match_id = d.match_id
GROUP BY clean_venue
HAVING matches_played >= 5
ORDER BY avg_runs_powerplay DESC;

-- ANSWER 7
-- Saurashtra & Holkar — highest powerplay runs (107, 97) but small sample size, take with caution
-- Arun Jaitley, Delhi — 94.46 avg powerplay runs, highest among high-sample venues
-- MA Chidambaram, Chennai — 90.85 powerplay runs but only 2.66 wickets, spinners don't trouble openers in powerplay, pace does the damage early
-- Dubai & Abu Dhabi — high wickets (3.04, 3.00) despite moderate runs — bowling conditions favor seam movement
-- Wankhede — 87.52 runs but 2.99 wickets — high scoring but wickets also fall, confirms it's an exciting ground for both sides
