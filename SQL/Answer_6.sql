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


SELECT 
clean_venue,
COUNT(DISTINCT cv.match_id) AS matches_played,
SUM(CASE WHEN d.batsman_runs IN ('4', '6') THEN 1 ELSE 0 END) as boundaries_venue_wise,
ROUND( SUM(CASE WHEN d.batsman_runs IN ('4', '6') THEN 1 ELSE 0 END) / COUNT(DISTINCT cv.match_id), 2) as avg_boundaries
FROM clean_venues cv
JOIN deliveries d ON cv.match_id = d.match_id
GROUP BY clean_venue
HAVING matches_played >= 5;

-- ANSWER 6
-- Himachal Pradesh Stadium — 47.77 (bowler friendly but boundaries still happen, small ground)
-- Wankhede — 42.88 (batter friendly, confirms Q1)
-- MA Chidambaram — 36.33 (lower boundaries, spin slows scoring, confirms Q1)
-- South Africa venues (Newlands, Kingsmead) — lowest boundaries, slower pitches
