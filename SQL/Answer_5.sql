USE ipl_analysis;

SELECT 
bowler,
SUM(CASE WHEN is_wicket = 1 THEN 1 ELSE 0 END) as wickets_taken
FROM deliveries
WHERE dismissal_kind NOT IN ('run out', 'retired hurt', 'obstructing the field')
GROUP BY bowler
ORDER BY wickets_taken DESC
LIMIT 10;

WITH over_distribution AS(
	SELECT 
    bowler, is_wicket,
    CASE 
		WHEN overs BETWEEN 0 AND 5 THEN "Power_Play"
        WHEN overs BETWEEN 6 and 14 THEN "Middle_Overs"
        WHEN overs BETWEEN 15 and 19 THEN "Death_Overs"
	END AS overs_category
    FROM deliveries
    WHERE is_wicket = '1'
)

SELECT
bowler,
overs_category,
SUM(is_wicket) AS total_wicket_per_category
FROM over_distribution
GROUP BY bowler, overs_category
ORDER BY bowler, overs_category;

-- ANSWER 5
-- B Kumar — 108 death, 77 powerplay — effective in both phases, rare
-- DL Chahar — 61 powerplay wickets, clear powerplay specialist
-- I Sharma — 62 powerplay wickets, also powerplay dominant
-- A Mishra & Harbhajan — majority in middle overs, classic spin pattern