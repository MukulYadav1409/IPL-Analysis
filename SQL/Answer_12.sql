USE ipl_analysis;

SELECT 
player_of_match,
COUNT(player_of_match) as number_of_times
FROM matches 
GROUP BY player_of_match
ORDER BY number_of_times DESC;

-- ANSWER 12
-- AB de Villiers leads with 25 Player of the Match awards, followed by CH Gayle (22), RG Sharma (19) and DA Warner (18) — 
-- all match-winners known for explosive innings. This metric captures impact performances rather than consistency, making it a 
-- strong indicator of game-changing ability.