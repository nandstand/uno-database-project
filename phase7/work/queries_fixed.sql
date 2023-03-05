-- Christian Fuller
-- CSCI 4125
-- Phase 7
-- SQL Queries

-- Problem 1
SELECT Name 
FROM Agent
WHERE AssistantID = (SELECT ID FROM Agent WHERE Name = 'Atriya Sen');

-- Problem 2

SELECT *
FROM House
WHERE House.Price 
BETWEEN 
    (SELECT LowerPrice FROM Buyer WHERE Name = 'Will Smith')
AND 
    (SELECT UpperPrice FROM Buyer WHERE Name = 'Will Smith');

-- Problem 3

-- Don't use views like this...
-- You could rewrite this as a single query

CREATE VIEW WSmithHouses
AS SELECT *
FROM House
WHERE House.Price 
BETWEEN 
	(SELECT LowerPrice FROM Buyer WHERE Name = 'Will Smith')
AND 
	(SELECT UpperPrice FROM Buyer WHERE Name = 'Will Smith');


SELECT DISTINCT Name
FROM Agent, WSmithHouses
WHERE Agent.ID = WSmithHousesInRange.AgentID;

-- Problem 4

SELECT Neighborhood, COUNT(*), COUNT(DISTINCT AgentID)
FROM House
GROUP BY Neighborhood;

-- Problem 5

SELECT Buyer.Name, COUNT(*)
FROM Buyer, Dependent
WHERE Buyer.SSN = Dependent.BuyerSSN
GROUP BY Buyer.Name
HAVING COUNT(*) >= 2;

-- Problem 6

SELECT Seller.Name
FROM House, Seller
WHERE House.SellerSSN = Seller.SSN
GROUP BY Seller.Name
HAVING SUM(House.Price) > 500000;

-- Problem 7

SELECT Address 
FROM House
WHERE REGEXP_LIKE(Address, '^[0-9]*(0|2|4|6|8)\s');