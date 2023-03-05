-- Christian Fuller
-- CSCI 4125
-- Phase 8


-- Trigger 1

CREATE OR REPLACE TRIGGER AddHouse
BEFORE INSERT ON House
FOR EACH ROW 
DECLARE
    listed Agent.HousesLIsted%type;
BEGIN
    SELECT HousesListed
    INTO listed
    FROM Agent
    WHERE Agent.ID = :new.AgentID;
    
    IF (listed < 4) THEN
        UPDATE Agent
        SET HousesListed = HousesListed + 1
        WHERE Agent.ID = :new.AgentID;
    ELSE
        RAISE_APPLICATION_ERROR(-20069, 'Agent is too busy!!!!!!');
    END IF;
END;
/

-- Trigger 2

CREATE OR REPLACE TRIGGER DeleteHouse
AFTER DELETE ON House
FOR EACH ROW
BEGIN
    UPDATE Agent
    SET HousesListed = HousesListed - 1
    WHERE Agent.ID = :old.AgentID;
END;
/

-- Trigger 3

CREATE OR REPLACE TRIGGER UpdateHouseAID
AFTER UPDATE OF AgentID ON House
FOR EACH ROW
DECLARE listed Agent.HousesListed%type;
BEGIN
    -- check if agent getting house is at max
    -- throw error, else
    -- increment their listed count
    -- then decrement old agent's listed count
    
    SELECT HousesListed
    INTO listed
    FROM Agent
    WHERE Agent.ID = :new.AgentID;
    
    IF (listed = 4) THEN
        RAISE_APPLICATION_ERROR(-20069, 'Agent is too busy!!!!!!');
    ELSE
        UPDATE Agent
        SET HousesListed = HousesListed + 1
        WHERE Agent.ID = :new.AgentID;
        
        UPDATE Agent
        SET HousesListed = HousesListed - 1
        WHERE Agent.ID = :old.AgentID;
    END IF;
END;
/