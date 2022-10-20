/*
	We are going to steal a bit of SQL from the example file given to us by Murach!
	The example file is create_ap.sql
	However, we will modify it to fit our needs.
*/
USE master
GO

IF DB_ID('bcmd') IS NOT NULL
	DROP DATABASE bcmd
GO

CREATE DATABASE bcmd -- Pg. 25 in the book for an example of this line
GO 

USE [bcmd]
GO

/*
	First we are going to create the tables for our database!
*/
-- Pg. 25 in the book for an example
CREATE TABLE actors
(
	Id			INT				NOT NULL IDENTITY PRIMARY KEY,
	FirstName	VARCHAR(25)		NOT NULL,
	LastName	VARCHAR(25)		NOT NULL,
	Gender		VARCHAR(10)		NULL
);

CREATE TABLE directors
(
	Id			INT				NOT NULL IDENTITY PRIMARY KEY,
	FirstName	VARCHAR(25)		NOT NULL,
	LastName	VARCHAR(25)		NOT NULL
);

CREATE TABLE directors_genres
(
	DirectorId		INT				NOT NULL REFERENCES directors(Id),
	Genre			VARCHAR(25)		NOT NULL
);

CREATE TABLE movies
(
	Id		INT				NOT NULL IDENTITY PRIMARY KEY,
	Name	VARCHAR(50)		NOT NULL,
	Year	INT				NOT NULL, -- Year is a keyword, but not a protected keyword. We can use it!
	Rank	INT				NULL -- Rank is a keyword, but not a protected keyword. We can use it!
);

CREATE TABLE movies_directors
(
	DirectorId		INT		NOT NULL REFERENCES directors(Id),
	MovieID			INT		NOT NULL REFERENCES movies(Id)
);

CREATE TABLE movies_genre
(
	MovieId		INT				NOT NULL REFERENCES movies(Id),
	Genre		VARCHAR(25)		NOT NULL 
);

CREATE TABLE roles
(
	ActorId		INT				NOT NULL REFERENCES actors(Id),
	MovieId		INT				NOT NULL REFERENCES movies(Id),
	Role		VARCHAR(25)		NOT NULL
);


/*
	Next, we will create some example data for our databases. 

	Pg. 31 in the book for an example

	Here is the structure:
		INSERT INTO actors (FirstName, LastName, Gender)
		VALUES ('Tom', 'Hanks', 'male');
*/

-- Insert 3-5 actors into the actors table
INSERT INTO actors (FirstName, LastName, Gender) 
VALUES ('Tom', 'Hanks', 'male');

INSERT INTO actors (FirstName, LastName, Gender) 
VALUES ('Reese', 'Witherspoon', 'female');

INSERT INTO actors (FirstName, LastName, Gender) 
VALUES ('Anne', 'Hathaway', 'female');

INSERT INTO actors (FirstName, LastName, Gender) 
VALUES ('Meryl', 'Streep', 'female');

-- Insert 3-5 directors into the directors table
INSERT INTO directors (FirstName, LastName)
VALUES ('Robert','Zemeckis');

INSERT INTO directors (FirstName, LastName)
VALUES ('Robert','Luketic');

INSERT INTO directors (FirstName, LastName)
VALUES ('Tom','Hooper');

INSERT INTO directors (FirstName, LastName)
VALUES ('David','Frankel');

-- Insert 3-5 movies into the movies table
INSERT INTO movies (Name, Year, Rank)
VALUES ('Forrest Gump',1994, 171); 

INSERT INTO movies (Name, Year, Rank)
VALUES ('Legally Blonde',2001, 849); 

INSERT INTO movies (Name, Year, Rank)
VALUES ('Les Miserables',2012, 893); 

INSERT INTO movies (Name, Year, Rank)
VALUES ('The Devil Wears Prada',2006, 688); 

-- Insert 1-2 genres for each director in your directors table into your directors_genres table
INSERT INTO directors_genres (DirectorId, Genre)
VALUES (1, 'Drama'); 

INSERT INTO directors_genres (DirectorId, Genre)
VALUES (2, 'Comedy'); 

INSERT INTO directors_genres (DirectorId, Genre)
VALUES (3, 'Musical'); 

INSERT INTO directors_genres (DirectorId, Genre)
VALUES (4, 'Comedy'); 

-- Insert a record to connect each of your movies to the director of that movie, using the movies_directors table
INSERT INTO movies_directors (DirectorId, MovieId)
VALUES (1, 1); 

INSERT INTO movies_directors (DirectorId, MovieId)
VALUES (2, 2); 

INSERT INTO movies_directors (DirectorId, MovieId)
VALUES (3, 3); 

INSERT INTO movies_directors (DirectorId, MovieId)
VALUES (4, 4); 

-- Insert a genre for each of the movies in your movies table, using the movies_genre table
INSERT INTO movies_genre (MovieId, Genre)
VALUES (1, 'Drama'); 

INSERT INTO movies_genre (MovieId, Genre)
VALUES (2, 'Comedu'); 

INSERT INTO movies_genre (MovieId, Genre)
VALUES (3, 'Musical'); 

INSERT INTO movies_genre (MovieId, Genre)
VALUES (4, 'Comedy'); 

-- Insert a record to connect the actors and movies in your database with a role, using the roles table
INSERT INTO roles (ActorId, MovieId, Role)
VALUES (1, 1, 'Forrest Gump');

INSERT INTO roles (ActorId, MovieId, Role)
VALUES (2, 2, 'Elle Woods');

INSERT INTO roles (ActorId, MovieId, Role)
VALUES (3, 3, 'Fantine');

INSERT INTO roles (ActorId, MovieId, Role)
VALUES (4, 4, 'Miranda Priestly');

SELECT * FROM movies_genre;

update movies_genre
set    Genre = case Genre
                          when 'Comedu' then 'Comedy'
                          else Genre
                     end

SELECT * FROM actors;
SELECT * FROM directors;
SELECT * FROM directors_genres;
SELECT * FROM movies;
SELECT * FROM movies_directors;
SELECT * FROM movies_genre;
SELECT * FROM roles;

