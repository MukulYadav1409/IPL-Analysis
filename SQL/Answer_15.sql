USE ipl_analysis;

SELECT 
bowler,
SUM(extra_runs) as total_extra_runs
FROM deliveries
WHERE extras_type IN ('wides', 'noballs')
GROUP BY bowler
ORDER BY total_extra_runs DESC;

-- ANSWER 15
-- Bowlers with the most wides and no-balls are predominantly high-volume bowlers who have played across many seasons — 
-- R Ashwin, B Kumar, DJ Bravo, and Malinga. When normalized by overs bowled, the picture would likely look different, 
-- but in absolute terms these bowlers have conceded the most bowler-responsible extras across IPL history.
