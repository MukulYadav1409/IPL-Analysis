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
	ROUND(AVG(target_runs - 1), 2) as avg_win_runs
FROM clean_venues
WHERE result = 'runs'
GROUP BY clean_venue
HAVING COUNT(*) >= 3
ORDER BY avg_win_runs DESC;

-- Answer 4
-- Note: Only matches where the team batting first won (result = 'runs') are considered. Matches won by wickets (chasing team won) are excluded, 
-- as the first innings score in those cases was insufficient to defend and would skew the average downward.

-- Holkar Stadium, Indore — highest at 245 (small ground, short boundaries, very batter friendly)   -- (if condition is removed)
-- Kingsmead & New Wanderers (South Africa) — lowest averages, slower pitches
-- Chinnaswamy at 192 confirms Q1 finding — batter friendly venue
-- MA Chidambaram at 175 — lower score still wins, spin takes effect
-- Wankhede at 184 vs Eden Gardens at 173 — both high-profile venues but different scoring patterns