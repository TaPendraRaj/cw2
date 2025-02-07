CREATE DATABASE VideoGameParlourDB;
USE VideoGameParlourDB;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Address VARCHAR(255),
    MemberType VARCHAR(20),
    MembershipFee DECIMAL(10,2),
    JoinDate DATE,
    DateOfBirth DATE
);

CREATE TABLE Sessions (
    SessionID INT PRIMARY KEY,
    Day VARCHAR(20),
    StartTime TIME,
    EndTime TIME,
    Type VARCHAR(20),
    Floor INT,
    Price DECIMAL(10,2)
);

CREATE TABLE Bookings (
    BookingID INT PRIMARY KEY,
    CustomerID INT,
    SessionID INT,
    Date DATE,
    MemberStatus VARCHAR(10),
    Fee DECIMAL(10,2),
    PrePaid VARCHAR(10),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (SessionID) REFERENCES Sessions(SessionID)
);

CREATE TABLE Staff (
    StaffID INT PRIMARY KEY,
    Name VARCHAR(50),
    Role VARCHAR(50)
);

CREATE TABLE SessionStaff (
    SessionID INT,
    StaffID INT,
    Role VARCHAR(50),
    PRIMARY KEY (SessionID, StaffID),
    FOREIGN KEY (SessionID) REFERENCES Sessions(SessionID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

CREATE TABLE Machines (
    MachineID INT PRIMARY KEY,
    Game VARCHAR(50),
    Year INT,
    Floor INT
);


CREATE TABLE Consoles (
    ConsoleID INT PRIMARY KEY,
    Name VARCHAR(50),
    Quantity INT
);

CREATE TABLE Games (
    GameID INT PRIMARY KEY,
    Name VARCHAR(50),
    PEGIRating VARCHAR(10),
    ConsoleID INT,
    Quantity INT,
    FOREIGN KEY (ConsoleID) REFERENCES Consoles(ConsoleID)
);

CREATE TABLE SessionConsoles (
    SessionID INT,
    Date DATE,
    ConsoleID INT,
    Quantity INT,
    PRIMARY KEY (SessionID, ConsoleID, Date),
    FOREIGN KEY (SessionID) REFERENCES Sessions(SessionID),
    FOREIGN KEY (ConsoleID) REFERENCES Consoles(ConsoleID)
);


INSERT INTO Customers VALUES 
(1, 'Saanvi', 'Bhatta', 'Baneshwor, Kathmandu', 'Standard', 1500, '2024-01-01', '2015-03-01'),
(2, 'Bill', 'Gates', 'Maitidevi, Kathmandu', 'Premium', 20000, '2024-07-06', '2001-10-12'),
(3, 'Elon', 'Musk', 'Putalisadak, Kathmandu', 'Premium', 20000, '2024-03-28', '2003-07-20'),
(4, 'Kamala', 'Harris', 'Kapan, Kathmandu', 'Standard', 1500, '2024-01-05', '1973-05-01'),
(5, 'Rishi', 'Sunak', 'London, UK', 'Standard', 1000, '2024-01-10', '1980-05-12'),
(6, 'Elena', 'Gomez', 'Madrid, Spain', 'Premium', 20000, '2024-02-15', '1995-07-08');


INSERT INTO Sessions VALUES 
(1, 'Sunday', '09:00:00', '21:00:00', 'Free', 1, 1500),
(2, 'Sunday', '09:00:00', '21:00:00', 'Free', 2, 1000),
(3, 'Saturday', '09:00:00', '21:00:00', 'Free', 1, 1500),
(4, 'Friday', '18:00:00', '22:00:00', 'Special', 2, 1000);

INSERT INTO Bookings VALUES 
(1, 1, 1, '2024-07-22', 'Y', NULL, NULL),
(2, 2, 1, '2024-07-22', 'N', 1500, 'N'),
(3, 3, 1, '2024-07-22', 'Y', 1000, 'Y'),
(4, 4, 1, '2024-08-25', 'N', 1500, 'N'),
(5, 5, 2, '2024-07-22', 'Y', 1000, 'N'),
(6, 6, 4, '2024-07-05', 'Y', 1000, 'Y');

INSERT INTO Staff VALUES 
(1, 'Sagar Aryal', 'Cafe'),
(2, 'Bikesh Khagdi', 'Maintenance'),
(3, 'Saroj Sapkota', 'Counter'),
(4, 'Jonathan Shrestha', 'Counter'),
(5, 'Rohan Chaudhary', 'Maintenance'),
(6, 'Rajeev Karmacharya', 'Cafe');

INSERT INTO SessionStaff VALUES 
(1, 1, 'Cafe'),
(1, 2, 'Maintenance'),
(1, 3, 'Counter'),
(2, 4, 'Counter'),
(2, 5, 'Maintenance'),
(2, 6, 'Cafe');


INSERT INTO Machines VALUES 
(23, 'COC', 2010, 1),
(123, 'GTA', 2013, 1),
(45, 'Spiderman', 2016, 2),
(1234, 'PUBG', 2004, 1);


INSERT INTO Consoles VALUES 
(1, 'XBOX 360', 3),
(2, 'PS3', 2),
(3, 'PS2', 3),
(4, 'Nintendo 64', 2);


INSERT INTO Games VALUES 
(1, 'Elden Ring: Shadow of the Erdtree', 'PG', 1, 3),
(2, 'Final Fantasy VII Rebirth', 'PG', 2, 2),
(3, 'Destiny 2: The Final Shape', 'PG', 3, 3),
(4, 'Tekken 8', 'PG', 2, 2);

INSERT INTO SessionConsoles VALUES 
(1, '2024-07-22', 3, 2),
(2, '2024-07-22', 2, 2);




SELECT CustomerID, FirstName, LastName 
FROM Customers 
WHERE CustomerID IN (
    SELECT CustomerID FROM Bookings WHERE SessionID = 1 AND PrePaid = 'N'
);


SELECT MachineID, Game FROM Machines WHERE Floor = 1 ORDER BY MachineID DESC;


SELECT COUNT(*) AS PS3_Game_Count FROM Games WHERE ConsoleID = (SELECT ConsoleID FROM Consoles WHERE Name = 'PS3');

SELECT StaffID, Name FROM Staff WHERE StaffID IN (
    SELECT StaffID FROM SessionStaff WHERE SessionID = 1 AND Role = 'Maintenance'
);

UPDATE Machines SET Floor = 2 WHERE Game = 'PUBG';

SELECT *FROM 
DELETE FROM Machines WHERE Game = 'GTA';

SELECT *FROM Machines;

Drop database VideoGameParlourDB;
