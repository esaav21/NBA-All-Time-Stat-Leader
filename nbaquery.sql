-- Question 1: 1. What is the average age of players in each team?
select  t.TeamName, avg(Age) as AvgAge
from Player p
join Team t on p.Team_1 = t.TeamID
group by t.TeamName;

-- 2. Which position has the highest average score per game?
select PositionName, round(avg(PTS),2)as AveragePoints
from Player p
join positions po on p.primary_position = po.PositionID
join [Season Stats] ss on ss.PlayerID = p.PlayerID
GROUP by PositionName
ORDER by avg(PTS) desc;


-- 3. Identify the top 5 players with the highest assists in the season.
select top 5 p.player_name, max(AST) as HighestAst
from Player p
join [Season Stats] ss on ss.PlayerID = p.PlayerID
GROUP by p.Player_name
ORDER BY HighestAst DESC;

-- 4. How many players have a shooting accuracy (field goal percentage) above 50%?
select count(*) as NumPlayers
from Player p
join [Season Stats] ss on ss.PlayerID = p.PlayerID
where ss.fg1 > .50 and ss.gp > 20;

-- 5. Compare the total points scored by each team in the season.
select t.TeamName, round(sum(ss.PTS),2) as PointsScored
from Player p
join Team t on p.Team_1 = t.TeamID
join [Season Stats] ss on ss.PlayerID = p.PlayerID
group by t.TeamName 
Order by PointsScored DESC;

-- 6. Find the player with the most steals per game.
select top 5 Player_name, STL
from Player p
join [Season Stats] ss on ss.PlayerID = p.PlayerID
where gp > 20 
order by ss.STL desc 

-- 7. What is the correlation between a player's experience (age) and their performance efficiency rating (PER)?
select player_name, age, per
from Player p
join [Season Stats] ss on ss.PlayerID = p.PlayerID
join [Advanced Stats] adv on adv.PlayerID = p.PlayerID
where gp > 20
order by per desc;

-- 8. Which team has the most diverse age range of players?
SELECT  t.TeamName,  MAX(p.age) - MIN(p.age) AS AgeRange
FROM Player p
JOIN Team t ON p.Team_1 = t.TeamID
GROUP BY t.TeamName
ORDER BY AgeRange DESC;
