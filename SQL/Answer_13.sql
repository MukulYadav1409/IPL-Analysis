USE ipl_analysis;

SELECT 
team, 
match_type,
COUNT(*) as type_wise_counts
FROM (
	SELECT team1 as team, match_type FROM matches
    UNION ALL
    SELECT team2 as team, match_type FROM matches
) AS all_teams
GROUP BY team, match_type
ORDER BY team, match_type;

-- ANSWER 13
-- Chennai Super Kings have the most dominant playoff record in IPL history, appearing in Finals multiple times across nearly every season 
-- they were eligible. Mumbai Indians follow closely as the second most consistent playoff team. Both franchises have been present since 
-- IPL's inception in 2008 and have maintained elite consistency over 15+ seasons — a stark contrast to newer or shorter-lived franchises 
-- like Kochi Tuskers Kerala and Pune Warriors who barely featured in playoffs before being dissolved. Royal Challengers Bangalore present 
-- the most interesting contrast — one of the highest League match appearances in IPL history yet historically rare Final appearances, 
-- making them the most consistent underperformers in knockout cricket despite fielding world-class talent across seasons.
