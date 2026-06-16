# 🏏 IPL Data Analysis (2008–2024)
### End-to-End Analytics Project | SQL · Power BI · Excel

> Across 17 IPL seasons and 1,095 matches, the data says something most fans wouldn't expect: **winning the toss barely matters.** Toss winners win the match only 48–55% of the time at most venues — basically a coin flip. That single finding, and 15 others like it, came from cleaning 250,000+ ball-by-ball deliveries and writing SQL from scratch to answer the questions a cricket analyst would actually ask.

---

## 📌 Project Overview

This project analyzes every IPL match and delivery from 2008 to 2024 — match results, toss decisions, venues, and ball-by-ball outcomes — to answer 15 specific business and cricket questions, then visualizes the findings in a 5-page interactive Power BI dashboard.

Unlike a templated EDA exercise, every question here was framed first, then solved in SQL — including handling messy real-world problems like inconsistent venue naming across seasons, super-over innings polluting "first 2 overs" analysis, and reserved keyword conflicts. The goal wasn't just to produce charts, but to think like an analyst sitting in front of a franchise's data team.

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|------|---------|
| MySQL | Data cleaning, CTEs, window-style aggregations, business queries |
| Power BI | 5-page interactive dashboard, DAX measures |
| Excel | Initial data exploration and date formatting |

---

## 📂 Dataset

- **Source:** [IPL Complete Dataset — Kaggle](https://www.kaggle.com/datasets/patrickb1912/ipl-complete-dataset-20082020)
- **Coverage:** 2008–2024, 17 seasons
- **Tables used:**
  - `matches` — 1,095 rows: season, venue, teams, toss, result, margin
  - `deliveries` — 250,000+ rows: ball-by-ball data including runs, wickets, extras, dismissal type

---

## ❓ Business Questions Answered

**🏟️ Venue Analysis**
1. Which stadiums favor batters, and which favor bowlers?
2. What's a safe score to defend at each venue?
3. Which venues produce the most boundaries on average?
4. Which venues produce the most powerplay runs and wickets?
5. Which venues favor chasing, and which favor defending?

**🎯 Toss & Strategy**

6. Does home advantage actually improve win chances?
7. Does toss decision (bat/field) vary meaningfully by venue?
8. Does winning the toss actually mean winning the match?

**🏏 Player Performance**

9. Who are the highest wicket takers, and in which phase of the innings do they strike — powerplay, middle, or death overs?
10. Who are the most consistent run scorers by average runs per season?
11. Who has won Player of the Match the most times?

**📊 Match Patterns & Records**

12. How often does a six get hit in the first 2 overs of an innings?
13. Which teams have appeared in the most Qualifiers, Eliminators, and Finals?
14. Which bowlers most often bowl overs with more than 6 balls (due to wides/no-balls)?
15. Which bowlers concede the most extra runs (wides and no-balls specifically)?

---

## 🔍 Key Findings

### Venue Intelligence
- **Rajiv Gandhi International Stadium (Hyderabad)** and **Arun Jaitley Stadium (Delhi)** are the most batter-friendly venues by runs-per-wicket ratio
- **Himachal Pradesh Cricket Association Stadium (Dharamsala)** and **Dr. YSR ACA-VDCA Stadium (Visakhapatnam)** favor bowlers the most
- **Holkar Cricket Stadium (Indore)** has produced the highest winning first-innings scores on average — a genuine batting paradise
- Chasing is the dominant strategy league-wide, but **Arun Jaitley Stadium** is a near-perfect 50-50 split between defending and chasing wins

### The Toss Myth, Busted
- Toss winners win the match only **48–55%** of the time at almost every major venue — statistically close to a coin flip
- This directly contradicts the common cricket-commentary assumption that winning the toss is a major advantage

### Bowling Phases
- **Jasprit Bumrah** has taken 101 of his 168 wickets in the death overs (15–19) — a genuine death-overs specialist, confirmed by the numbers, not just reputation
- **Deepak Chahar** and **Ishant Sharma** are clear powerplay specialists, with the majority of their wickets coming in the first 6 overs
- **Bhuvneshwar Kumar** is one of the rare bowlers who is genuinely dangerous in both powerplay and death overs

### Consistency Over Big Innings
- **Virat Kohli** averages 471 runs per season across 17 seasons — the most consistent high-volume run scorer in IPL history
- **AB de Villiers** has won Player of the Match 25 times, the most in IPL history, reflecting his reputation as a genuine match-winner rather than just a high scorer

### Franchise Legacy
- **Chennai Super Kings** have reached 10 Finals — the most dominant playoff record of any franchise
- **Royal Challengers Bangalore** present the most interesting contrast: among the highest number of league appearances in IPL history, yet historically rare in Finals — the most consistent playoff underperformer despite consistently fielding star talent

### Personal Curiosity, Answered With Data
- A six was hit in the first 2 overs of an innings in **419 of 1,095 matches (38%)** — nearly 2 in 5 matches start with an early statement of intent
- In 60 of those matches, **both teams** hit a six in the first 2 overs

---

## 🧹 Real-World Data Challenges Solved

This dataset looked clean on the surface but had several issues a beginner-level analysis would have missed entirely:

- **Inconsistent venue naming** — the same stadium appeared under 2–3 different names across seasons (e.g. "M Chinnaswamy Stadium" vs "M Chinnaswamy Stadium, Bengaluru" vs "M.Chinnaswamy Stadium"). Solved with a `CASE WHEN` venue-cleaning CTE reused across every venue-based query.
- **Super over innings (inning 3 & 4)** also start their over count at 0, which would have falsely inflated "six in the first 2 overs" and "extra balls per over" results if not explicitly filtered out with `inning IN (1, 2)`.
- **`over` is a reserved keyword in MySQL** — renamed to `overs` across the schema to avoid syntax errors.
- **Run outs were initially counted as bowler wickets** — corrected by filtering `dismissal_kind` to exclude run outs, retired hurt, and obstruction, since those aren't credited to the bowler.
- **Home ground analysis is approximate, not official** — home ground was derived by mapping each franchise to its primary city, which means neutral-venue and playoff matches hosted in that city also get counted. This was documented transparently rather than presented as more precise than it is.

---

## 📊 Dashboard

A 5-page interactive Power BI dashboard built on a live MySQL connection, covering 20 visuals across team, venue, toss, bowler, and playoff analysis.

**Page 1 — Overview**
Top run scorers, top wicket takers, most Player of the Match awards, matches per season
<img width="1308" height="737" alt="Screenshot 2026-06-16 125449" src="https://github.com/user-attachments/assets/7a02e5b8-9a5a-4836-85ec-69d503d9fc20" />

**Page 2 — Venue Analysis (Pitch Report)**
Batter vs bowler friendly venues, average winning score, boundaries per match, powerplay runs by venue
<img width="1307" height="732" alt="Screenshot 2026-06-16 125509" src="https://github.com/user-attachments/assets/dabf52dc-14f7-493e-a9d9-e68642bdbb34" />

**Page 3 — Toss & Match Strategy**
Toss decision by venue, toss win vs match win %, chase vs defend win %, home ground win %
<img width="1303" height="727" alt="Screenshot 2026-06-16 125538" src="https://github.com/user-attachments/assets/a68af74b-eb44-49f9-bfef-57d0735c6edb" />

**Page 4 — Bowler Intelligence**
Wicket takers by phase (powerplay/middle/death), economy rate, extra runs conceded, overs exceeding 6 balls
<img width="1307" height="731" alt="Screenshot 2026-06-16 125632" src="https://github.com/user-attachments/assets/150d2679-f54f-4e66-a2ac-99c57eaae7d0" />

**Page 5 — Playoffs & Team Performance**
Total wins per team, playoff appearances by match type, top batsmen by total runs
<img width="1303" height="733" alt="Screenshot 2026-06-16 125651" src="https://github.com/user-attachments/assets/017f433b-ca3e-4977-8c37-9c8c3bf86d47" />

---

## 🔍 Sample SQL Query

The venue-cleaning CTE, reused across nearly every venue-based query in this project:

```sql
WITH clean_venues AS (
    SELECT *,
        CASE
            WHEN venue LIKE '%Chinnaswamy%' THEN 'M Chinnaswamy Stadium, Bengaluru'
            WHEN venue LIKE '%Wankhede%' THEN 'Wankhede Stadium, Mumbai'
            WHEN venue LIKE '%Eden Gardens%' THEN 'Eden Gardens, Kolkata'
            WHEN venue LIKE '%Arun Jaitley%' OR venue LIKE '%Feroz Shah Kotla%' 
                THEN 'Arun Jaitley Stadium, Delhi'
            -- additional venue mappings continue in full script
            ELSE venue
        END AS clean_venue
    FROM matches
)
SELECT 
    clean_venue,
    ROUND(SUM(d.total_runs) / COUNT(DISTINCT m.match_id), 2) AS avg_runs_per_match,
    ROUND(SUM(d.total_runs) / SUM(d.is_wicket), 2) AS runs_per_wicket
FROM clean_venues m
JOIN deliveries d ON m.match_id = d.match_id
WHERE d.inning IN (1, 2)
GROUP BY clean_venue
HAVING COUNT(DISTINCT m.match_id) >= 5
ORDER BY runs_per_wicket DESC;
```

All 15 queries are documented in [`SQL/analysis_queries.sql`](SQL/analysis_queries.sql).

---

## 📁 Project Structure

```
IPL-Analysis/
│
├── Data/
│   └── (Kaggle CSV files — not uploaded due to size; see Dataset section for source link)
│
├── SQL/
│   └── analysis_queries.sql
│
├── PowerBI/
│   ├── IPL_Dashboard.pbix
│   └── (dashboard screenshots)
│
└── README.md
```

---

## 🧠 Lessons Learned

- Real ball-by-ball data needs phase-aware thinking — powerplay, middle overs, and death overs behave so differently that combining them hides the most interesting patterns (Bumrah's death-overs dominance, for example, is invisible in a career-wide wicket count)
- Reserved keywords and inconsistent naming are normal in real datasets, not exceptions — building a reusable cleaning CTE early saved having to repeat the same fix in 10+ later queries
- Disproving a popular belief with data (the toss myth) is far more interesting and credible than confirming what everyone already assumes
- Documenting a method's limitations openly — like the approximate nature of the home ground analysis — is part of doing the analysis correctly, not a weakness to hide

---

## 👤 Author

**Mukul** — Aspiring Data Analyst, building toward AI & SaaS entrepreneurship

[LinkedIn](https://www.linkedin.com/in/mukulyadav1409/)

*This project is part of my Data Analytics learning path: Excel → SQL → Power BI → Python → Statistics → Data Science → ML → AI*
