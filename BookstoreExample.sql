/* STEP 1 & 2: In order to create a new SQL file I created a New Query and then file save as BookstoreExample in My SQL Server Management Studio folder where I've been saving our homework exercises. I'm also currently in a multiline comment */

USE master;
GO -- STEP 2 & 4.1: this is me switching to master, this is a single line comment

DROP DATABASE IF EXISTS CaseysBookstore; -- STEP 4.2: this is me dropping the database if it were to exist, but it doesn't so this executed successfully with no error because I used IF EXISTS

CREATE DATABASE CaseysBookstore; -- STEP 4.3: this is me creating my database

USE CaseysBookstore;
GO -- STEP 5: this is me using SQL to switch to my database I just created

/* TABLE CREATING */
CREATE TABLE Customers (
CustomerId		INT				NOT NULL IDENTITY PRIMARY KEY,
FirstName		VARCHAR(20)		NOT NULL,
LastName		VARCHAR(20)		NOT NULL,
Email			VARCHAR(50)		NULL,
Phone			INT				NOT NULL
); -- STEP 6: This is me creating a table for my Customers

CREATE TABLE Books (
ISBN			BIGINT			NOT NULL IDENTITY PRIMARY KEY,
Title			VARCHAR(50)		NOT NULL,
AUTHOR			VARCHAR(50)		NOT NULL
); -- STEP 6: This is me creating a table for my Books. 

CREATE TABLE Orders (
OrderID		   INT				NOT NULL IDENTITY PRIMARY KEY,
OrderCost	   INT				NOT NULL,
CustomerID	   INT				NOT NULL REFERENCES Customers(CustomerId),
ISBN		   BIGINT			NOT NULL REFERENCES Books(ISBN)
); -- STEP 6.1: This is me creating a table for my orders. This table has a foreign key that pulls from my Books table and my Customers table. 

/* FIXING MY MISTAKE, I made phone number an integer instead of a string so I'm going to fix it here. My phone numbers are bigger than 2,147,483,647 and I didn't want to make it a bigint*/
ALTER TABLE Customers
ALTER COLUMN Phone VARCHAR(20);

/* Okay now we can go to STEP 7: DATA INSERTION. */
INSERT INTO Customers (FirstName, LastName, Email, Phone)
VALUES
	('Mario','Red','mariored@gmail.com','5689521245'),
	('Luigi','Green','luigigreen@gmail.com','5846325131'),
	('Princess','Pink', NULL, '2546984521'),
	('Toad','Yellow',NULL, '2548963215'),
	('Waluigi','Purple', NULL, '6589543120'),
	('Daisy','Brown', NULL,'89562451231');


INSERT INTO Books (ISBN, Title, Author)
VALUES
	(9781088068557, 'Be Like Socks!', 'Casey Craiger'),
	(9781801041508, 'I Love You to the Moon and Back', 'Amelia Hepworth'),
	(9780544874350, 'Stellaluna', 'Jannell Cannon'),
	(9781338744897, 'David Goes to School', 'David Shannon'),
	(9780590929974, 'A Bad Case of Stripes', 'David Shannon');

-- I got the error: "cannot insert explicit value for identity column in table 'Books' when IDENTITY_INSERT is set to OFF" because I am trying to set values for my Books Table's Primary Key: ISBN. Because I'm the only one using this and we're practicing I'm going to turn identity insertion on even though I know that's a no no. I'll turn it off after I execute my script.
	
	SET IDENTITY_INSERT Books ON

-- I inserted my data so now I'm going to turn it back off, even though I know I'm not supposed to be doing this at all. 

	SET IDENTITY_INSERT Books OFF

INSERT INTO Orders (OrderCost, CustomerID, ISBN) 
VALUES
	(17, 1, 9781088068557),
	(24, 2, 9781801041508),
	(13, 3, 9780544874350),
	(13, 4, 9780590929974),
	(24, 1, 9781801041508);

SELECT * FROM Customers

-- STEP 8: Adding a column
ALTER TABLE Books
ADD Fiction BIT;

-- STEP 9: Deleting a column
ALTER TABLE Books
DROP COLUMN Fiction;

-- STEP 10: Deleting a record
DELETE FROM Customers WHERE FirstName = 'Daisy';

-- STEP 11 & 11.1: I am selecting my Orders table and sorting in ascending order by OrderCost so I can see who has spent the least amount of money so I can give them a coupon the next time they come to see me to incentivize them to spend more.
SELECT * FROM Orders
ORDER BY OrderCost;

-- STEP 12 & 12.1: I am selecting my Orders table and sorting in descending order by OrderCost so I can see who has spent the most money (on this order) so I can thank them for their support because it's important as a business owner to maintain the relationship with your top spenders. 
SELECT * FROM Orders
ORDER BY OrderCost DESC;

-- STEP 13: Here is am selecting the top 10 values from my Orders table in my CaseyBookstore database.
SELECT TOP (10)
	   (OrderID),
	   (OrderCost),
	   (CustomerID),
	   (ISBN)
  FROM [CaseysBookstore].[dbo].[Orders];

-- STEP 14: Here is a SELECT statement using the IN keyword to pull records from my Orders table where the ISBN is 9781088068557 or 9781338744897 . I could be doing this because David Shannon is now publishing through a new company and I need to report to the government how many books I sold with the old ISBNs.
SELECT COUNT(*)
FROM Orders
WHERE ISBN IN ('9781088068557','9781338744897'
);

-- STEP 15 & 15.1: Here I am selecting orders within a certain range because >$10 but <$20 gets a specific tier for shipping cost.
SELECT *
FROM Orders
WHERE OrderCost BETWEEN 10 and 20;

-- STEP 16.1 Inner Join, I did this to see what customers I have in my system that have placed an order. 
SELECT DISTINCT c.CustomerId, c.FirstName, c.LastName
	FROM Customers c
	INNER JOIN Orders o
	ON c.CustomerId = o.CustomerID

-- STEP 16.2 Left Join, I did this so that I could see how many copies I have sold of each title. 
SELECT b.Title, COUNT(o.OrderID) AS 'Copies Sold'
	FROM Books b
	LEFT JOIN Orders o ON b.ISBN = o.ISBN
	GROUP BY b.Title;

SELECT * FROM Orders;
SELECT * FROM Books;

-- STEP 16.3 Right Join, I did this because there is a problem with my orders and I need to get customer contact information for the orders that will be affected.
SELECT c.Email, c.Phone, o.OrderID
	FROM Customers c
	RIGHT JOIN Orders o
	ON c.CustomerId = o.CustomerID

	SELECT * FROM Orders;

-- STEP 17 Here I am inserting a record with a null value. 
INSERT INTO Customers (FirstName, LastName, Email, Phone)
VALUES
	('Bowser', 'Blue', NULL, 7895412365);

SELECT * FROM Customers;

-- STEP 18.1 Here is am calculating the total amount that I made from the sale of all books. 
SELECT SUM(OrderCost)
FROM Orders;

-- STEP 18.2 Here I am checking how many customers I have.
SELECT COUNT(*) FROM Customers;  

-- STEP 18.2 Here is am checking how many customers did not give me their email.
SELECT COUNT(*)
FROM Customers
WHERE Email IS NULL;

--STEP 18.3 Here I am averaging the order cost (for not nullable) but I can't do one with nullable without inserting new values and altering a table as I used email as my nullable column. 
SELECT AVG(OrderCost)
FROM Orders;

-- STEP 18.4 We care about the results of the SUM because that shows me how much I made today. We care about the COUNT because that tells me how many customers I have. We care about the AVG order cost because that helps me provide inquiring local authors with a good price for them to set their books at. 

-- STEP 20 Here I have made a statement using GROUP BY so that I can see how many books I have in my system by each author. 
SELECT COUNT(Title), Author
FROM CaseysBookstore.dbo.Books
GROUP BY Author;

SELECT * FROM Books


/* STEP 19 & 21 Showing the full name of a person WITH CONCAT, returning a result set with a column that does not exist in the table with two values concatenated (while not creating a new column)
We would want this information to be able to create nice mailing labels (for promotional/marketing materials and/or holiday cards) where the first line is the recipients full name. Doing this would save us the time of having to manually add each persons last name to their first name.*/

SELECT FirstName, LastName,
CONCAT(FirstName,' ', LastName) AS 'Full Name'
FROM Customers;

-- STEP 21 Showing the full name of a person WITHOUT CONCAT
SELECT FirstName + ' '+ LastName AS 'Full Name'
FROM Customers;

 