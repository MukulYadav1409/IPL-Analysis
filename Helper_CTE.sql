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


WITH home_teams AS (
    SELECT match_id, city, team1, team2, winner,
        CASE 
            WHEN city = 'Mumbai' THEN 'Mumbai Indians'
            WHEN city = 'Kolkata' THEN 'Kolkata Knight Riders'
            WHEN city = 'Delhi' THEN 'Delhi Capitals'
            WHEN city = 'Chennai' THEN 'Chennai Super Kings'
            WHEN city = 'Bangalore' THEN 'Royal Challengers Bangalore'
            WHEN city = 'Hyderabad' THEN 'Sunrisers Hyderabad'
            WHEN city = 'Mohali' OR city = 'Chandigarh' THEN 'Kings XI Punjab'
            WHEN city = 'Jaipur' THEN 'Rajasthan Royals'
            WHEN city = 'Pune' THEN 'Rising Pune Supergiant'
            WHEN city = 'Visakhapatnam' THEN 'Sunrisers Hyderabad'
        END AS home_team
    FROM matches
)

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