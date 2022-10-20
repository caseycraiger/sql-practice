SELECT * FROM actors

SELECT TOP 2 * FROM actors;
SELECT TOP 10 * FROM actors;

SELECT FirstName, LastName FROM actors WHERE FirstName = 'Tom';

INSERT INTO actors (FirstName, LastName, Gender)
VALUES ('Reese', 'Witherspoon', 'female');

SELECT DISTINCT FirstName, LastName FROM actors;

SELECT FirstName, LastName FROM actors WHERE Firstname = 'Reese' and Lastname = 'Witherspoon';

SELECT FirstName, LastName FROM actors WHERE Firstname = 'Reese' or Firstname = 'Anne';

SELECT FirstName, LastName FROM actors WHERE NOT Firstname = 'Reese';

SELECT * FROM actors WHERE FirstName = 'Reese' AND NOT Id = 5;

SELECT * from directors WHERE FirstName IN ('Robert','Tom');

SELECT * from movies;

SELECT * FROM movies WHERE Rank BETWEEN 700 AND 900;

SELECT
MAX(Rank)AS 'Max Rank',
MIN(Rank)AS 'Min Rank',
AVG(Rank)AS 'Average Rank',
COUNT(*)AS 'All Records', 
COUNT(Rank) AS 'All Ranked Records'
FROM movies;

INSERT INTO directors_genres (DirectorId, Genre)
VALUES 
(1, 'Adventure'),
(2, 'Family'),
(3, 'Action'),
(4, 'Romance'),
(5, 'Fantasy');

SELECT d.Firstname, d.LastName, dg.Genre 
FROM directors d
INNER JOIN directors_genres dg
ON d.Id = dg.DirectorId;

SELECT * FROM directors_genres

INSERT INTO directors (FirstName, LastName)
VALUES ('Ron','Howard');

SELECT d.Firstname, d.LastName, dg.Genre 
FROM directors d
LEFT JOIN directors_genres dg
ON d.Id = dg.DirectorId;

SELECT d.Firstname, d.LastName, dg.Genre 
FROM directors d
RIGHT JOIN directors_genres dg
ON d.Id = dg.DirectorId;

SELECT d.Firstname, d.LastName, dg.Genre 
FROM directors d
FULL OUTER JOIN directors_genres dg
ON d.Id = dg.DirectorId;

SELECT d.Firstname, d.LastName, COUNT(dg.Genre) AS 'Number of Genres'
FROM directors d
INNER JOIN directors_genres dg
ON d.Id = dg.DirectorId
GROUP BY FirstName, LastName
ORDER BY 3 DESC

SELECT m.Id, m.Name, mg.Genre, m.Rank
FROM movies m
INNER JOIN movies_genre mg
ON m.Id = mg.MovieId
WHERE m.Rank >
	( 
		SELECT AVG(Rank)
		FROM movies
	);

