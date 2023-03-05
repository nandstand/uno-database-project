-- Christian Fuller
-- CSCI 4125
-- Phase 5
-- SQL Queries

-- Problem 1
SELECT Address FROM House WHERE (Price > 340000);

-- Problem 2
SELECT Address, Price FROM House 
    WHERE Neighborhood = 'French Quarter'
    ORDER BY Price;

-- Problem 3
SELECT Address FROM House WHERE Address LIKE '%Bourbon';

-- Problem 4
SELECT Name, ID FROM Agent WHERE AssistantID IS NULL;

-- Problem 5
SELECT Name, UpperPrice FROM Buyer 
    WHERE UpperPrice BETWEEN 325000 AND 350000;

-- Problem 6
SELECT Name, AgentID FROM Buyer WHERE AgentID = 'A01';

-- Problem 7
SELECT Price FROM House 
    WHERE Price = (SELECT MAX(Price) FROM House)
    OR Price = (SELECT MIN(Price) FROM House);

-- Problem 8
SELECT AVG(Price) FROM House;

-- Problem 9
SELECT Address, Price FROM House 
    WHERE Price = (SELECT MAX(Price) FROM House);

-- Problem 10
SELECT Address, Price FROM House 
    WHERE Price < 1.2 * (SELECT AVG(Price) FROM House);