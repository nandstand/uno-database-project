DROP TABLE Dependent;
DROP TABLE Buyer;
DROP TABLE House;
DROP TABLE Seller;
DROP TABLE Agent;

CREATE TABLE Seller (
	SSN CHAR(11),
	Name VARCHAR(24),
	Phone CHAR(12),
	CONSTRAINT Seller_PK PRIMARY KEY(SSN)
);

CREATE TABLE Agent (
	ID CHAR(3),
	Name VARCHAR(24),
	Phone CHAR(12),
	AssistantID CHAR(3),
	CONSTRAINT Agent_PK PRIMARY KEY(ID),
	CONSTRAINT AssistantID_FK FOREIGN KEY(AssistantID) REFERENCES Agent(ID)
);

CREATE TABLE Buyer (
	SSN CHAR(11),
	Name VARCHAR(24),
	LowerPrice NUMBER(10),
	UpperPrice NUMBER(10),
	AgentID CHAR(3),
	CONSTRAINT Buyer_PK PRIMARY KEY(SSN),
	CONSTRAINT Buyer_AgentID_FK FOREIGN KEY(AgentID) REFERENCES Agent(ID)
);

CREATE TABLE House (
	ID CHAR(3),
	Address VARCHAR(30),
	Neighborhood VARCHAR(30),
	Price NUMBER(10),
	SquareFeet NUMBER(6),
	SellerSSN CHAR(11),
	AgentID CHAR(3),
	CONSTRAINT House_PK PRIMARY KEY(ID),
	CONSTRAINT SellerSSN_FK FOREIGN KEY(SellerSSN) REFERENCES Seller(SSN),
	CONSTRAINT House_AgentID_FK FOREIGN KEY(AgentID) REFERENCES Agent(ID)
);

CREATE TABLE Dependent (
	BuyerSSN CHAR(11),
	Name CHAR(24),
	Age NUMBER(2),
	CONSTRAINT Dependent_PK PRIMARY KEY(BuyerSSN, Name),
	CONSTRAINT BuyerSSN_FK FOREIGN KEY(BuyerSSN) REFERENCES Buyer(SSN)
);
