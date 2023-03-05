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

CREATE VIEW DependentsPerBuyer
AS SELECT BuyerSSN, COUNT(*) AS Count
FROM Dependent
GROUP BY BuyerSSN;

SELECT Buyer.Name
FROM Buyer, DependentsPerBuyer
WHERE Buyer.SSN = DependentsPerBuyer.BuyerSSN
AND DependentsPerBuyer.Count >= 2;

-- Problem 6

CREATE VIEW SellerHouseValues
AS SELECT House.Price, Seller.Name
FROM House, Seller
WHERE House.SellerSSN = Seller.SSN;

SELECT Name
FROM SellerHouseValues
GROUP BY Name
HAVING SUM(Price) > 500000;

-- Problem 7

