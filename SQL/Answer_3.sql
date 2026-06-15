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
toss_decision,
COUNT(toss_decision) as total_venue_wise
FROM clean_venues
GROUP BY clean_venue, toss_decision
ORDER BY clean_venue;

-- Answer 3
-- Teams heavily prefer fielding first at most venues:

-- M Chinnaswamy Stadium — 9 bat vs 85 field (massive preference to chase)
-- Eden Gardens — 30 bat vs 63 field
-- Wankhede Stadium — 30 bat vs 88 field
-- Arun Jaitley Stadium — 36 bat vs 54 field

-- Exception — teams prefer batting first at:

-- MA Chidambaram Stadium, Chennai — 48 bat vs 37 field (spin-friendly, dew factor less relevant)
-- Kingsmead — 10 bat vs 5 field (South Africa venues behave differently)