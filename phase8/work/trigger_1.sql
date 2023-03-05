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