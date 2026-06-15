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

-- SELECT 
-- clean_venue,
-- COUNT(DISTINCT match_id) as total_matches,
-- SUM( CASE 
-- 		WHEN (toss_decision = 'bat') AND (result = 'runs') THEN 1 
--         WHEN (toss_decision = 'bat') AND (result = 'wickets') THEN -1 
--         ElSE 0
--         END) as defend,
-- SUM( CASE
-- 		WHEN (toss_decision = 'field') AND (result = 'wickets') THEN 1 
--         WHEN (toss_decision = 'field') AND (result = 'runs') THEN -1 
--         ELSE 0
--         END) as chase
-- FROM clean_venues
-- GROUP BY clean_venue;


SELECT 
    clean_venue,
    COUNT(DISTINCT match_id) AS total_matches,
    SUM(CASE WHEN result = 'wickets' THEN 1 ELSE 0 END) AS chases_won,
    SUM(CASE WHEN result = 'runs' THEN 1 ELSE 0 END) AS defenses_won,
    ROUND(SUM(CASE WHEN result = 'wickets' THEN 1 ELSE 0 END) / COUNT(DISTINCT match_id) * 100, 2) AS chase_win_pct,
    ROUND(SUM(CASE WHEN result = 'runs' THEN 1 ELSE 0 END) / COUNT(DISTINCT match_id) * 100, 2) AS defend_win_pct
FROM clean_venues
GROUP BY clean_venue
HAVING total_matches >= 10
ORDER BY chase_win_pct DESC;


-- Notice something interesting — totals don't always add to 100%. That gap is super overs and tied matches where result is 
-- neither 'runs' nor 'wickets'.

-- ANSWER 9
-- Chasing is the dominant strategy across most IPL venues, with Sawai Mansingh Stadium (Jaipur) and Sharjah Cricket Stadium showing 
-- the strongest chase-win percentages — likely driven by dew factor in evening matches. Arun Jaitley Stadium (Delhi) is the 
-- most neutral venue with an exact 50-50 split. Brabourne Stadium is one of the rare IPL venues where defending first holds a slight edge.

-- Clean results. Key observations:
-- Strong chasing grounds:

-- Sawai Mansingh, Jaipur — 64.91% chase wins (dew factor, shorter boundaries)
-- Sharjah — 64.29% (night games, dew heavily favors chasing)
-- Eden Gardens — 56.99%

-- Balanced/defending grounds:

-- Arun Jaitley, Delhi — exactly 50/50, perfectly neutral
-- Brabourne, Mumbai — 51.85% slightly favors defending, rare in IPL
-- MA Chidambaram, Chennai — not in your output, check if it got filtered