CREATE TABLE Vip_Guest (
    Guest_Id         VARCHAR2(20),
    First_Name       VARCHAR2(30) NOT NULL,
    Last_Name        VARCHAR2(30) NOT NULL,
    Membership_Rank  VARCHAR2(30) NOT NULL,
    Carbon_Credits   NUMBER,
    PRIMARY KEY (Guest_Id)
);

---
CREATE TABLE Individual_Guest (
    Guest_Id       VARCHAR2(20),
    Date_Of_Birth  DATE NOT NULL,
    Nationality    VARCHAR2(50) NOT NULL,
    Email          VARCHAR2(60) NOT NULL,
    Phone_Number   VARCHAR2(20) NOT NULL,
    PRIMARY KEY (Guest_Id),
    FOREIGN KEY (Guest_Id) REFERENCES Vip_Guest(Guest_Id)
);

CREATE TABLE Corporate_Guest (
    Guest_Id              VARCHAR2(20),
    Company_Name          VARCHAR2(100) NOT NULL,
    Job_Title             VARCHAR2(100),
    Department            VARCHAR2(100),
    Expense_Account_Code  VARCHAR2(50),
    Corporate_Email       VARCHAR2(60) NOT NULL,
    PRIMARY KEY (Guest_Id),
    FOREIGN KEY (Guest_Id) REFERENCES Vip_Guest(Guest_Id)
);


------
CREATE TABLE Vip_Package (
    Package_Id           VARCHAR2(20),
    Package_Name         VARCHAR2(50) NOT NULL,
    Price                NUMBER(6,2) NOT NULL,
    Capacity             INT,
    Include_Paddock_Access CHAR(1) NOT NULL,  -- Whether includes paddock access (Y or N)
    Include_hospitality   CHAR(1) NOT NULL,  -- Whether includes hospitality (Y or N)
    Sustainability_Rating INT, -- Sustainability rating from 1 to 5
    Duration             INT NOT NULL, --minutes in integer
    Description          VARCHAR2(1000),
    PRIMARY KEY (Package_Id),
 -- Added constraints
    CONSTRAINT check_capacity CHECK (Capacity > 0),

    CONSTRAINT check_include_paddock_access CHECK (Include_Paddock_Access IN ('Y', 'N')),

    CONSTRAINT check_include_hospitality CHECK (Include_hospitality IN ('Y', 'N')),

    CONSTRAINT check_sustainability_rating CHECK (Sustainability_Rating BETWEEN 1 AND 5)

);


------
CREATE TABLE Race_Event (
    Event_Id         VARCHAR2(20),
    Event_Name       VARCHAR2(50) NOT NULL,
    Start_Date       DATE NOT NULL,
    End_Date         DATE NOT NULL,
    Track_Name       VARCHAR2(50) NOT NULL,
    Expected_Attendence NUMBER NOT NULL,
    PRIMARY KEY (Event_Id)
);


------
CREATE TABLE Experience_Venue (
    Venue_Id             VARCHAR2(20),
    Venue_Name           VARCHAR2(50) NOT NULL,
    Venue_Type           VARCHAR2(50) NOT NULL,
    Capacity             INT NOT NULL,
    Location             VARCHAR2(50) NOT NULL,
    Has_Bar_Service      CHAR(1) NOT NULL, -- Whether has bar service (Y or N)
    Status               VARCHAR2(5) NOT NULL, --Whether is available (Yes or no)
    PRIMARY KEY (Venue_Id),
-- Added constraints
    CONSTRAINT check_capacity CHECK (Capacity > 0),

    CONSTRAINT check_has_bar_service CHECK (Has_Bar_Service IN ('Y', 'N')),

    CONSTRAINT check_status CHECK (Status IN ('Available', 'Unavailable'))

);


------
CREATE TABLE Experience_Session (
  Session_Id    VARCHAR2(20),
  Package_Id    VARCHAR2(20) NOT NULL,
  Event_Id      VARCHAR2(20) NOT NULL,
  Venue_Id      VARCHAR2(20) NOT NULL,
  Session_Date  DATE NOT NULL,
  Start_Time    TIMESTAMP NOT NULL,
  End_Time      TIMESTAMP NOT NULL,
  Available_Slots INT NOT NULL,
  Weather_Condition VARCHAR2(100),
  Status        VARCHAR2(20)NOT NULL, -- VARCHAR2(10) to accommodate 'SCHEDULED', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED'
  Created_Date  DATE NOT NULL,
  PRIMARY KEY (Session_Id),
  FOREIGN KEY (Package_Id) REFERENCES Vip_Package(Package_Id),
  FOREIGN KEY (Event_Id) REFERENCES Race_Event(Event_Id),
  FOREIGN KEY (Venue_Id) REFERENCES Experience_Venue(Venue_Id),
  -- Added constraints

  CONSTRAINT check_available_slots CHECK (Available_Slots >= 0),

  CONSTRAINT check_status CHECK (Status IN ('SCHEDULED', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED'))

);



------
CREATE TABLE Booking (
  Booking_Id VARCHAR2(20),
  Session_Id VARCHAR2(20) NOT NULL,
  Booking_Capacity INT,
  Total_Amount INT NOT NULL,
  Sustainability_Rating INT,
  Booking_Description VARCHAR2(1000),
  Booking_Status  VARCHAR2(20) NOT NULL, -- VARCHAR2(10) to accommodate 'CONFIRMED', 'CANCELLED', 'PENDING', 'NO_SHOW'
  Booking_Channel VARCHAR2(30) NOT NULL, -- VARCHAR2(30) to accommodate 'ONLINE', 'PHONE', 'IN_PERSON', 'AGENCY', 'OTHER'
  IP_Address VARCHAR2(100),

  PRIMARY KEY (Booking_Id),
  FOREIGN KEY (Session_Id) REFERENCES Experience_Session(Session_Id),
  -- Added constraints

  CONSTRAINT check_booking_capacity CHECK (Booking_Capacity >= 0),

  CONSTRAINT check_total_amount CHECK (Total_Amount >= 0),

  CONSTRAINT check_sustainability_rating CHECK (Sustainability_Rating BETWEEN 1 AND 5),

  CONSTRAINT check_booking_status CHECK (Booking_Status IN ('CONFIRMED', 'CANCELLED', 'PENDING','NO_SHOW')),

  CONSTRAINT check_booking_channel CHECK (Booking_Channel IN ('ONLINE', 'PHONE', 'IN_PERSON', 'AGENCY', 'OTHER'))
);


------
CREATE TABLE Booking_Guest (
  Booking_Id VARCHAR2(20),
  Guest_Id   VARCHAR2(20),
  Is_Primary           CHAR(1), -- Whether the guest is the primary contact (Y or N)
  Dietary_Requirements VARCHAR2(200),
  Special_Needs        VARCHAR2(200),
  Allergies            VARCHAR2(200),
  Check_In_Status VARCHAR2(20) NOT NULL,
  Check_In_Time   TIMESTAMP NOT NULL,
  Created_Date    DATE NOT NULL,

  PRIMARY KEY (Booking_Id, Guest_Id),
  FOREIGN KEY (Booking_Id) REFERENCES Booking(Booking_Id),
  FOREIGN KEY (Guest_Id) REFERENCES Vip_Guest(Guest_Id),
   -- Added constraints

  CONSTRAINT check_is_primary CHECK (Is_Primary IN ('Y', 'N')),

  CONSTRAINT check_check_in_status CHECK (Check_In_Status IN ('CHECKED_IN', 'NOT_ARRIVED', 'NOT_SHOW'))
);



------
CREATE TABLE Payment (
  Payment_Id VARCHAR2(20),
  Booking_Id VARCHAR2(20),
  Payment_Amount                 NUMBER NOT NULL,
  Payment_Date_Time        TIMESTAMP NOT NULL,
  Payment_Reference_Number VARCHAR2(50) NOT NULL,
  Payment_Status VARCHAR2(20) NOT NULL CHECK (Payment_Status IN ('PENDING', 'COMPLETED', 'FAILED', 'REFUNDED', 'CANCELLED')),

  PRIMARY KEY (Payment_Id),
  FOREIGN KEY (Booking_Id) REFERENCES Booking(Booking_Id)
);




---
CREATE TABLE Card_Payment (
  Payment_Id       VARCHAR2(20),
  Card_Number_Hash VARCHAR2(30) NOT NULL,
  Card_Type        VARCHAR2(20),
  Card_Holder_Name VARCHAR2(60),
  Billing_Address  VARCHAR2(200),
  Currency         VARCHAR2(20),

  PRIMARY KEY (Payment_Id),
  FOREIGN KEY (Payment_Id) REFERENCES Payment(Payment_Id),
  -- Added constraints

  -- Assuming these are the only supported card types

  -- need to write in to assumptions report

  CONSTRAINT check_card_type CHECK (Card_Type IN ('VISA', 'MASTERCARD', 'AMEX', 'DISCOVER')),

  -- Assuming these are the only supported currencies

  -- need to write in to assumptions report

  CONSTRAINT check_currency CHECK (Currency IN ('USD', 'EUR', 'GBP', 'AUD', 'CAD', 'CNY', 'JPY'))

);


CREATE TABLE Crypto_Payment (
  Payment_Id          VARCHAR2(20),
  From_Wallet_Address VARCHAR2(200),
  To_Wallet_Address   VARCHAR2(200),
  Crypto_Currency     VARCHAR2(50) NOT NULL,
  Transaction_Hash    VARCHAR2(30) NOT NULL,

  PRIMARY KEY (Payment_Id),
  FOREIGN KEY (Payment_Id) REFERENCES Payment(Payment_Id),
  -- Added constraints

  -- Assuming these are the only supported cryptocurrencies

  -- need to write in to assumptions report

  CONSTRAINT check_crypto_currency CHECK (Crypto_Currency IN ('BTC', 'ETH', 'USDT', 'USDC'))

);


------
CREATE TABLE Guest_Feedback (
  Feedback_Id    VARCHAR2(20),
  Booking_Id     VARCHAR2(20),
  Overall_Rating INT, -- Overall rating from 1 to 5,
  Venue_Rating   INT, -- Venue rating from 1 to 5
  Staff_Rating   INT, -- Staff rating from 1 to 5
  Sustainability_Score INT, -- Sustainability score from 1 to 5
  Comments       VARCHAR2(1000),
  Feedback_Date_Time VARCHAR2(30) NOT NULL,
  Would_Recommend    VARCHAR2(1), -- Whether the guest would recommend the experience (Y or N)
  Suggestions        VARCHAR2(1000),

  PRIMARY KEY (Feedback_Id),
  FOREIGN KEY (Booking_Id) REFERENCES Booking(Booking_Id),
   -- Added constraints

  CONSTRAINT check_overall_rating CHECK (Overall_Rating BETWEEN 1 AND 5),

  CONSTRAINT check_venue_rating CHECK (Venue_Rating BETWEEN 1 AND 5),

  CONSTRAINT check_staff_rating CHECK (Staff_Rating BETWEEN 1 AND 5),

  CONSTRAINT check_sustainability_score CHECK (Sustainability_Score BETWEEN 1 AND 5),

  CONSTRAINT check_would_recommend CHECK (Would_Recommend IN ('Y', 'N'))
);


------
CREATE TABLE Hospitality_Staff (
  Staff_Id   VARCHAR2(20),
  First_Name VARCHAR2(30) NOT NULL,
  Last_Name  VARCHAR2(30) NOT NULL,
  Capacity   Number,
  First_Language   VARCHAR2(30) NOT NULL,
  Second_Language  VARCHAR2(30),
  Experience_Level VARCHAR2(20),
  Availability_Status VARCHAR2(20) NOT NULL, -- Availability status (AVAILABLE or UNAVAILABLE)
  Rating              INT, -- Rating from 1 to 5

  PRIMARY KEY (Staff_Id),
   -- Added constraints

  CONSTRAINT check_availability_status CHECK (Availability_Status IN ('AVAILABLE', 'UNAVAILABLE')),

  CONSTRAINT check_rating CHECK (Rating BETWEEN 1 AND 5)

);


------
CREATE TABLE Staff_Assignment (
  Staff_Id             VARCHAR2(20),
  Booking_Id           VARCHAR2(20),
  Role                 VARCHAR2(20) NOT NULL, -- Role of the staff (e.g., WAITER, BARTENDER, HOST, SECURITY, CLEANER, OTHER)
  Start_Time           TIMESTAMP NOT NULL,
  End_Time             TIMESTAMP NOT NULL,
  Status               VARCHAR2(10) NOT NULL,
  Special_Instructions VARCHAR2(200),
  Created_Date         DATE NOT NULL,

  PRIMARY KEY (Staff_Id, Booking_Id),
  FOREIGN KEY (Staff_Id) REFERENCES Hospitality_Staff(Staff_Id),
  FOREIGN KEY (Booking_Id) REFERENCES Booking(Booking_Id),
  -- Added constraints

  CONSTRAINT check_status CHECK (Status IN ('ASSIGNED', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED')),

  CONSTRAINT check_start_time CHECK (Start_Time < End_Time),

  -- Assuming these are the only supported roles

  -- need to write in to assumptions report

  CONSTRAINT check_role CHECK (Role IN ('WAITER', 'BARTENDER', 'HOST', 'SECURITY', 'CLEANER', 'OTHER'))

);


-- Insert 10 rows into Vip_Package
INSERT ALL
  INTO Vip_Package (Package_Id, Package_Name, Price, Capacity, Include_Paddock_Access, Include_Hospitality, Sustainability_Rating, Duration, Description)
  VALUES ('VP001', 'Bronze Experience',       850,  50, 'N', 'Y', 2, 1, 'Basic access with hospitality lounge.')

  INTO Vip_Package (Package_Id, Package_Name, Price, Capacity, Include_Paddock_Access, Include_Hospitality, Sustainability_Rating, Duration, Description)
  VALUES ('VP002', 'Silver Package',         1450,  40, 'Y', 'Y', 3, 2, 'Includes paddock tour and lounge access.')

  INTO Vip_Package (Package_Id, Package_Name, Price, Capacity, Include_Paddock_Access, Include_Hospitality, Sustainability_Rating, Duration, Description)
  VALUES ('VP003', 'Gold VIP Pass',          2650,  30, 'Y', 'Y', 4, 2, 'Premium access and VIP hospitality.')

  INTO Vip_Package (Package_Id, Package_Name, Price, Capacity, Include_Paddock_Access, Include_Hospitality, Sustainability_Rating, Duration, Description)
  VALUES ('VP004', 'Diamond Elite',          3950,  20, 'Y', 'Y', 5, 3, 'Full access with EV tech tour and fine dining.')

  INTO Vip_Package (Package_Id, Package_Name, Price, Capacity, Include_Paddock_Access, Include_Hospitality, Sustainability_Rating, Duration, Description)
  VALUES ('VP005', 'Platinum Ultimate',      5250,  15, 'Y', 'Y', 5, 3, 'Includes backstage access and premium services.')

  INTO Vip_Package (Package_Id, Package_Name, Price, Capacity, Include_Paddock_Access, Include_Hospitality, Sustainability_Rating, Duration, Description)
  VALUES ('VP006', 'Eco Bronze Lounge',       950,  50, 'N', 'Y', 4, 1, 'Eco-certified hospitality experience.')

  INTO Vip_Package (Package_Id, Package_Name, Price, Capacity, Include_Paddock_Access, Include_Hospitality, Sustainability_Rating, Duration, Description)
  VALUES ('VP007', 'Tech Silver Access',     1750,  35, 'Y', 'Y', 3, 2, 'Includes EV tech briefings and pit access.')

  INTO Vip_Package (Package_Id, Package_Name, Price, Capacity, Include_Paddock_Access, Include_Hospitality, Sustainability_Rating, Duration, Description)
  VALUES ('VP008', 'Sustainable Gold',       2850,  25, 'Y', 'Y', 5, 2, 'Zero-emission promise and organic catering.')

  INTO Vip_Package (Package_Id, Package_Name, Price, Capacity, Include_Paddock_Access, Include_Hospitality, Sustainability_Rating, Duration, Description)
  VALUES ('VP009', 'Trackside Diamond',      4050,  20, 'Y', 'Y', 4, 3, 'Best race views and personalized service.')

  INTO Vip_Package (Package_Id, Package_Name, Price, Capacity, Include_Paddock_Access, Include_Hospitality, Sustainability_Rating, Duration, Description)
  VALUES ('VP010', 'Legacy Platinum Pass',   5650,  10, 'Y', 'Y', 5, 4, 'Legacy perks with extended hospitality access.')
SELECT * FROM dual;
-- Insert 10 rows into Race_Event
INSERT ALL
  INTO Race_Event (Event_Id, Event_Name, Start_Date, End_Date, Track_Name, Expected_Attendance)
  VALUES ('RE001', 'Sydney Grand Prix',         TO_DATE('2025-09-14', 'YYYY-MM-DD'), TO_DATE('2025-09-16', 'YYYY-MM-DD'), 'Sydney Motorsport Park',        85000)

  INTO Race_Event (Event_Id, Event_Name, Start_Date, End_Date, Track_Name, Expected_Attendance)
  VALUES ('RE002', 'Tokyo E-Prix',              TO_DATE('2025-10-01', 'YYYY-MM-DD'), TO_DATE('2025-10-02', 'YYYY-MM-DD'), 'Odaiba Street Circuit',         72000)

  INTO Race_Event (Event_Id, Event_Name, Start_Date, End_Date, Track_Name, Expected_Attendance)
  VALUES ('RE003', 'London Electric Circuit',   TO_DATE('2025-10-18', 'YYYY-MM-DD'), TO_DATE('2025-10-20', 'YYYY-MM-DD'), 'Royal Docklands Track',         91000)

  INTO Race_Event (Event_Id, Event_Name, Start_Date, End_Date, Track_Name, Expected_Attendance)
  VALUES ('RE004', 'Berlin City Challenge',     TO_DATE('2025-11-05', 'YYYY-MM-DD'), TO_DATE('2025-11-07', 'YYYY-MM-DD'), 'Tempelhof Circuit',             68000)

  INTO Race_Event (Event_Id, Event_Name, Start_Date, End_Date, Track_Name, Expected_Attendance)
  VALUES ('RE005', 'Melbourne EV Masters',      TO_DATE('2025-11-25', 'YYYY-MM-DD'), TO_DATE('2025-11-27', 'YYYY-MM-DD'), 'Albert Park Circuit',           93000)

  INTO Race_Event (Event_Id, Event_Name, Start_Date, End_Date, Track_Name, Expected_Attendance)
  VALUES ('RE006', 'Seoul Night Circuit',       TO_DATE('2025-12-10', 'YYYY-MM-DD'), TO_DATE('2025-12-12', 'YYYY-MM-DD'), 'Yeouido Island Track',          61000)

  INTO Race_Event (Event_Id, Event_Name, Start_Date, End_Date, Track_Name, Expected_Attendance)
  VALUES ('RE007', 'Los Angeles EV Fest',       TO_DATE('2026-01-03', 'YYYY-MM-DD'), TO_DATE('2026-01-05', 'YYYY-MM-DD'), 'Downtown LA Circuit',           87000)

  INTO Race_Event (Event_Id, Event_Name, Start_Date, End_Date, Track_Name, Expected_Attendance)
  VALUES ('RE008', 'Dubai Desert Circuit',      TO_DATE('2026-01-20', 'YYYY-MM-DD'), TO_DATE('2026-01-22', 'YYYY-MM-DD'), 'Dubai Marina Track',            75000)

  INTO Race_Event (Event_Id, Event_Name, Start_Date, End_Date, Track_Name, Expected_Attendance)
  VALUES ('RE009', 'Singapore EV Challenge',    TO_DATE('2026-02-14', 'YYYY-MM-DD'), TO_DATE('2026-02-16', 'YYYY-MM-DD'), 'Marina Bay Circuit',            98000)

  INTO Race_Event (Event_Id, Event_Name, Start_Date, End_Date, Track_Name, Expected_Attendance)
  VALUES ('RE010', 'New York Eco GP',           TO_DATE('2026-03-01', 'YYYY-MM-DD'), TO_DATE('2026-03-03', 'YYYY-MM-DD'), 'Brooklyn Cruise Terminal',      81000)
SELECT * FROM dual;
-- Insert 10 rows into Experience_Venue
INSERT ALL
  INTO Experience_Venue (Venue_Id, Venue_Name, Venue_Type, Capacity, Location, Has_Bar_Service, Status)
  VALUES ('V001', 'EV Tech Pavilion',         'Tech Zone',        120, 'Sydney',          'Y', 'AVAILABLE')

  INTO Experience_Venue (Venue_Id, Venue_Name, Venue_Type, Capacity, Location, Has_Bar_Service, Status)
  VALUES ('V002', 'Green Lounge',             'Hospitality',       80, 'Melbourne',       'Y', 'AVAILABLE')

  INTO Experience_Venue (Venue_Id, Venue_Name, Venue_Type, Capacity, Location, Has_Bar_Service, Status)
  VALUES ('V003', 'Future Trackside Bar',     'Bar',               60, 'Tokyo',           'Y', 'UNAVAILABLE')

  INTO Experience_Venue (Venue_Id, Venue_Name, Venue_Type, Capacity, Location, Has_Bar_Service, Status)
  VALUES ('V004', 'Skyline VIP Lounge',       'Hospitality',      100, 'Dubai',           'N', 'AVAILABLE')

  INTO Experience_Venue (Venue_Id, Venue_Name, Venue_Type, Capacity, Location, Has_Bar_Service, Status)
  VALUES ('V005', 'Urban Experience Zone',    'Tech Zone',        150, 'Singapore',       'N', 'AVAILABLE')

  INTO Experience_Venue (Venue_Id, Venue_Name, Venue_Type, Capacity, Location, Has_Bar_Service, Status)
  VALUES ('V006', 'Eco Chill Lounge',         'Hospitality',       90, 'London',          'Y', 'UNAVAILABLE')

  INTO Experience_Venue (Venue_Id, Venue_Name, Venue_Type, Capacity, Location, Has_Bar_Service, Status)
  VALUES ('V007', 'Velocity Test Lab',        'Tech Zone',        110, 'Seoul',           'N', 'AVAILABLE')

  INTO Experience_Venue (Venue_Id, Venue_Name, Venue_Type, Capacity, Location, Has_Bar_Service, Status)
  VALUES ('V008', 'Sunset Grand Bar',         'Bar',               70, 'Los Angeles',     'Y', 'AVAILABLE')

  INTO Experience_Venue (Venue_Id, Venue_Name, Venue_Type, Capacity, Location, Has_Bar_Service, Status)
  VALUES ('V009', 'Marina View Lounge',       'Hospitality',       85, 'Abu Dhabi',       'Y', 'UNAVAILABLE')

  INTO Experience_Venue (Venue_Id, Venue_Name, Venue_Type, Capacity, Location, Has_Bar_Service, Status)
  VALUES ('V010', 'Pulse Energy Hub',         'Tech Zone',        130, 'New York',        'N', 'AVAILABLE')
SELECT * FROM dual;
-- Insert 10 rows into Experience_Session
INSERT INTO Experience_Session
(Session_Id, Package_Id, Event_Id, Venue_Id,
 Session_Date, Start_Time, End_Time,
 Available_Slots, Weather_Condition, Status, Created_Date)
VALUES
('S001', 'VP001', 'RE001', 'V001',
 TO_DATE('2025-09-14', 'YYYY-MM-DD'),
 TO_DATE('09:00', 'HH24:MI'),
 TO_DATE('10:00', 'HH24:MI'),
 35, 'Sunny', 'SCHEDULED',
 TO_DATE('2025-08-01', 'YYYY-MM-DD'));

INSERT INTO Experience_Session
(Session_Id, Package_Id, Event_Id, Venue_Id,
 Session_Date, Start_Time, End_Time,
 Available_Slots, Weather_Condition, Status, Created_Date)
VALUES
('S002', 'VP002', 'RE002', 'V002',
 TO_DATE('2025-09-15', 'YYYY-MM-DD'),
 TO_DATE('10:30', 'HH24:MI'),
 TO_DATE('11:30', 'HH24:MI'),
 18, 'Cloudy', 'SCHEDULED',
 TO_DATE('2025-08-01', 'YYYY-MM-DD'));
 
INSERT INTO Experience_Session
(Session_Id, Package_Id, Event_Id, Venue_Id,
 Session_Date, Start_Time, End_Time,
 Available_Slots, Weather_Condition, Status, Created_Date)
VALUES
('S003', 'VP003', 'RE003', 'V003',
 TO_DATE('2025-09-16', 'YYYY-MM-DD'),
 TO_DATE('13:00', 'HH24:MI'),
 TO_DATE('14:00', 'HH24:MI'),
 15, 'Rainy', 'SCHEDULED',
 TO_DATE('2025-08-01', 'YYYY-MM-DD'));
 
INSERT INTO Experience_Session
(Session_Id, Package_Id, Event_Id, Venue_Id,
 Session_Date, Start_Time, End_Time,
 Available_Slots, Weather_Condition, Status, Created_Date)
VALUES
('S004', 'VP004', 'RE004', 'V004',
 TO_DATE('2025-09-17', 'YYYY-MM-DD'),
 TO_DATE('14:30', 'HH24:MI'),
 TO_DATE('15:30', 'HH24:MI'),
 12, 'Windy', 'SCHEDULED',
 TO_DATE('2025-08-01', 'YYYY-MM-DD'));

INSERT INTO Experience_Session
(Session_Id, Package_Id, Event_Id, Venue_Id,
 Session_Date, Start_Time, End_Time,
 Available_Slots, Weather_Condition, Status, Created_Date)
VALUES
('S005', 'VP005', 'RE005', 'V005',
 TO_DATE('2025-09-18', 'YYYY-MM-DD'),
 TO_DATE('17:00', 'HH24:MI'),
 TO_DATE('18:00', 'HH24:MI'),
 30, 'Rainy', 'SCHEDULED',
 TO_DATE('2025-08-01', 'YYYY-MM-DD'));
 
INSERT INTO Experience_Session
(Session_Id, Package_Id, Event_Id, Venue_Id,
 Session_Date, Start_Time, End_Time,
 Available_Slots, Weather_Condition, Status, Created_Date)
VALUES
('S006', 'VP006', 'RE006', 'V006',
 TO_DATE('2025-09-19', 'YYYY-MM-DD'),
 TO_DATE('09:00', 'HH24:MI'),
 TO_DATE('10:00', 'HH24:MI'),
 32, 'Cloudy', 'SCHEDULED',
 TO_DATE('2025-08-01', 'YYYY-MM-DD'));
 
INSERT INTO Experience_Session
(Session_Id, Package_Id, Event_Id, Venue_Id,
 Session_Date, Start_Time, End_Time,
 Available_Slots, Weather_Condition, Status, Created_Date)
VALUES
('S007', 'VP007', 'RE007', 'V007',
 TO_DATE('2025-09-20', 'YYYY-MM-DD'),
 TO_DATE('11:00', 'HH24:MI'),
 TO_DATE('12:00', 'HH24:MI'),
 16, 'Sunny', 'SCHEDULED',
 TO_DATE('2025-08-01', 'YYYY-MM-DD'));

INSERT INTO Experience_Session
(Session_Id, Package_Id, Event_Id, Venue_Id,
 Session_Date, Start_Time, End_Time,
 Available_Slots, Weather_Condition, Status, Created_Date)
VALUES
('S008', 'VP008', 'RE008', 'V008',
 TO_DATE('2025-09-21', 'YYYY-MM-DD'),
 TO_DATE('13:30', 'HH24:MI'),
 TO_DATE('14:30', 'HH24:MI'),
 14, 'Windy', 'SCHEDULED',
 TO_DATE('2025-08-01', 'YYYY-MM-DD'));
 
INSERT INTO Experience_Session
(Session_Id, Package_Id, Event_Id, Venue_Id,
 Session_Date, Start_Time, End_Time,
 Available_Slots, Weather_Condition, Status, Created_Date)
VALUES
('S009', 'VP009', 'RE009', 'V009',
 TO_DATE('2025-09-22', 'YYYY-MM-DD'),
 TO_DATE('15:00', 'HH24:MI'),
 TO_DATE('16:00', 'HH24:MI'),
 18, 'Rainy', 'SCHEDULED',
 TO_DATE('2025-08-01', 'YYYY-MM-DD'));

INSERT INTO Experience_Session
(Session_Id, Package_Id, Event_Id, Venue_Id,
 Session_Date, Start_Time, End_Time,
 Available_Slots, Weather_Condition, Status, Created_Date)
VALUES
('S010', 'VP010', 'RE010', 'V010',
 TO_DATE('2025-09-23', 'YYYY-MM-DD'),
 TO_DATE('17:00', 'HH24:MI'),
 TO_DATE('18:00', 'HH24:MI'),
 30, 'Sunny', 'SCHEDULED',
 TO_DATE('2025-08-01', 'YYYY-MM-DD'));
 
INSERT INTO Experience_Session
(Session_Id, Package_Id, Event_Id, Venue_Id,
 Session_Date, Start_Time, End_Time,
 Available_Slots, Weather_Condition, Status, Created_Date)
VALUES
('S011', 'VP001', 'RE001', 'V001',
 TO_DATE('2025-09-24', 'YYYY-MM-DD'),
 TO_DATE('09:00', 'HH24:MI'),
 TO_DATE('10:00', 'HH24:MI'),
 42, 'Cloudy', 'SCHEDULED',
 TO_DATE('2025-08-01', 'YYYY-MM-DD'));
 
INSERT INTO Experience_Session
(Session_Id, Package_Id, Event_Id, Venue_Id,
 Session_Date, Start_Time, End_Time,
 Available_Slots, Weather_Condition, Status, Created_Date)
VALUES
('S012', 'VP002', 'RE002', 'V002',
 TO_DATE('2025-09-25', 'YYYY-MM-DD'),
 TO_DATE('10:30', 'HH24:MI'),
 TO_DATE('11:30', 'HH24:MI'),
 19, 'Sunny', 'SCHEDULED',
 TO_DATE('2025-08-01', 'YYYY-MM-DD'));
 
INSERT INTO Experience_Session
(Session_Id, Package_Id, Event_Id, Venue_Id,
 Session_Date, Start_Time, End_Time,
 Available_Slots, Weather_Condition, Status, Created_Date)
VALUES
('S013', 'VP003', 'RE003', 'V003',
 TO_DATE('2025-09-26', 'YYYY-MM-DD'),
 TO_DATE('13:00', 'HH24:MI'),
 TO_DATE('14:00', 'HH24:MI'),
 16, 'Rainy', 'SCHEDULED',
 TO_DATE('2025-08-01', 'YYYY-MM-DD'));
 
INSERT INTO Experience_Session
(Session_Id, Package_Id, Event_Id, Venue_Id,
 Session_Date, Start_Time, End_Time,
 Available_Slots, Weather_Condition, Status, Created_Date)
VALUES
('S013', 'VP003', 'RE003', 'V003',
 TO_DATE('2025-09-26', 'YYYY-MM-DD'),
 TO_DATE('13:00', 'HH24:MI'),
 TO_DATE('14:00', 'HH24:MI'),
 16, 'Rainy', 'SCHEDULED',
 TO_DATE('2025-08-01', 'YYYY-MM-DD'));
 
 INSERT INTO Experience_Session (
  Session_Id, Package_Id, Event_Id, Venue_Id,
  Session_Date, Start_Time, End_Time,
  Available_Slots, Weather_Condition, Status, Created_Date
) VALUES (
  'S014', 'VP004', 'RE004', 'V004',
  TO_DATE('2025-09-27', 'YYYY-MM-DD'),
  TO_TIMESTAMP('14:00', 'HH24:MI'),
  TO_TIMESTAMP('15:00', 'HH24:MI'),
  20, 'Cloudy', 'SCHEDULED',
  TO_DATE('2025-08-01', 'YYYY-MM-DD'));
  
INSERT INTO Experience_Session
(Session_Id, Package_Id, Event_Id, Venue_Id,
 Session_Date, Start_Time, End_Time,
 Available_Slots, Weather_Condition, Status, Created_Date)
VALUES
('S015', 'VP005', 'RE005', 'V005',
 TO_DATE('2025-09-28', 'YYYY-MM-DD'),
 TO_DATE('16:00', 'HH24:MI'),
 TO_DATE('17:00', 'HH24:MI'),
 50, 'Sunny', 'SCHEDULED',
 TO_DATE('2025-08-01', 'YYYY-MM-DD'));

INSERT INTO Experience_Session
(Session_Id, Package_Id, Event_Id, Venue_Id,
 Session_Date, Start_Time, End_Time,
 Available_Slots, Weather_Condition, Status, Created_Date)
VALUES
('S016', 'VP006', 'RE006', 'V006',
 TO_DATE('2025-09-29', 'YYYY-MM-DD'),
 TO_DATE('09:00', 'HH24:MI'),
 TO_DATE('10:00', 'HH24:MI'),
 18, 'Cloudy', 'SCHEDULED',
 TO_DATE('2025-08-01', 'YYYY-MM-DD'));

INSERT INTO Experience_Session
(Session_Id, Package_Id, Event_Id, Venue_Id,
 Session_Date, Start_Time, End_Time,
 Available_Slots, Weather_Condition, Status, Created_Date)
VALUES
('S017', 'VP007', 'RE007', 'V007',
 TO_DATE('2025-09-30', 'YYYY-MM-DD'),
 TO_DATE('11:00', 'HH24:MI'),
 TO_DATE('12:00', 'HH24:MI'),
 16, 'Sunny', 'SCHEDULED',
 TO_DATE('2025-08-01', 'YYYY-MM-DD'));

INSERT INTO Experience_Session
(Session_Id, Package_Id, Event_Id, Venue_Id,
 Session_Date, Start_Time, End_Time,
 Available_Slots, Weather_Condition, Status, Created_Date)
VALUES
('S017', 'VP007', 'RE007', 'V007',
 TO_DATE('2025-09-30', 'YYYY-MM-DD'),
 TO_DATE('11:00', 'HH24:MI'),
 TO_DATE('12:00', 'HH24:MI'),
 16, 'Sunny', 'SCHEDULED',
 TO_DATE('2025-08-01', 'YYYY-MM-DD'));

INSERT INTO Experience_Session
(Session_Id, Package_Id, Event_Id, Venue_Id,
 Session_Date, Start_Time, End_Time,
 Available_Slots, Weather_Condition, Status, Created_Date)
VALUES
('S018', 'VP008', 'RE008', 'V008',
 TO_DATE('2025-10-01', 'YYYY-MM-DD'),
 TO_DATE('13:00', 'HH24:MI'),
 TO_DATE('14:00', 'HH24:MI'),
 12, 'Cloudy', 'SCHEDULED',
 TO_DATE('2025-08-01', 'YYYY-MM-DD'));

INSERT INTO Experience_Session
(Session_Id, Package_Id, Event_Id, Venue_Id,
 Session_Date, Start_Time, End_Time,
 Available_Slots, Weather_Condition, Status, Created_Date)
VALUES
('S019', 'VP009', 'RE009', 'V009',
 TO_DATE('2025-10-02', 'YYYY-MM-DD'),
 TO_DATE('15:30', 'HH24:MI'),
 TO_DATE('16:30', 'HH24:MI'),
 14, 'Rainy', 'SCHEDULED',
 TO_DATE('2025-08-01', 'YYYY-MM-DD'));

INSERT INTO Experience_Session
(Session_Id, Package_Id, Event_Id, Venue_Id,
 Session_Date, Start_Time, End_Time,
 Available_Slots, Weather_Condition, Status, Created_Date)
VALUES
('S020', 'VP010', 'RE010', 'V010',
 TO_DATE('2025-10-03', 'YYYY-MM-DD'),
 TO_DATE('09:00', 'HH24:MI'),
 TO_DATE('10:00', 'HH24:MI'),
 18, 'Sunny', 'SCHEDULED',
 TO_DATE('2025-08-01', 'YYYY-MM-DD'));

INSERT INTO Experience_Session
(Session_Id, Package_Id, Event_Id, Venue_Id,
 Session_Date, Start_Time, End_Time,
 Available_Slots, Weather_Condition, Status, Created_Date)
VALUES
('S021', 'VP001', 'RE001', 'V003',
 TO_DATE('2025-10-04', 'YYYY-MM-DD'),
 TO_DATE('11:30', 'HH24:MI'),
 TO_DATE('12:30', 'HH24:MI'),
 10, 'Windy', 'SCHEDULED',
 TO_DATE('2025-08-01', 'YYYY-MM-DD'));

INSERT INTO Experience_Session
(Session_Id, Package_Id, Event_Id, Venue_Id,
 Session_Date, Start_Time, End_Time,
 Available_Slots, Weather_Condition, Status, Created_Date)
VALUES
('S022', 'VP002', 'RE002', 'V004',
 TO_DATE('2025-10-05', 'YYYY-MM-DD'),
 TO_DATE('13:00', 'HH24:MI'),
 TO_DATE('14:00', 'HH24:MI'),
 12, 'Cloudy', 'SCHEDULED',
 TO_DATE('2025-08-01', 'YYYY-MM-DD'));

INSERT INTO Experience_Session
(Session_Id, Package_Id, Event_Id, Venue_Id,
 Session_Date, Start_Time, End_Time,
 Available_Slots, Weather_Condition, Status, Created_Date)
VALUES
('S023', 'VP003', 'RE003', 'V005',
 TO_DATE('2025-10-06', 'YYYY-MM-DD'),
 TO_DATE('15:00', 'HH24:MI'),
 TO_DATE('16:00', 'HH24:MI'),
 8, 'Rainy', 'SCHEDULED',
 TO_DATE('2025-08-01', 'YYYY-MM-DD'));
 
INSERT INTO Experience_Session
(Session_Id, Package_Id, Event_Id, Venue_Id,
 Session_Date, Start_Time, End_Time,
 Available_Slots, Weather_Condition, Status, Created_Date)
VALUES
('S024', 'VP004', 'RE004', 'V006',
 TO_DATE('2025-10-07', 'YYYY-MM-DD'),
 TO_DATE('16:30', 'HH24:MI'),
 TO_DATE('17:30', 'HH24:MI'),
 7, 'Sunny', 'SCHEDULED',
 TO_DATE('2025-08-01', 'YYYY-MM-DD'));
 
INSERT INTO Experience_Session
(Session_Id, Package_Id, Event_Id, Venue_Id,
 Session_Date, Start_Time, End_Time,
 Available_Slots, Weather_Condition, Status, Created_Date)
VALUES
('S025', 'VP005', 'RE005', 'V007',
 TO_DATE('2025-10-08', 'YYYY-MM-DD'),
 TO_DATE('09:30', 'HH24:MI'),
 TO_DATE('10:30', 'HH24:MI'),
 16, 'Cloudy', 'SCHEDULED',
 TO_DATE('2025-08-01', 'YYYY-MM-DD'));

INSERT INTO Experience_Session
(Session_Id, Package_Id, Event_Id, Venue_Id,
 Session_Date, Start_Time, End_Time,
 Available_Slots, Weather_Condition, Status, Created_Date)
VALUES
('S026', 'VP006', 'RE006', 'V008',
 TO_DATE('2025-10-09', 'YYYY-MM-DD'),
 TO_DATE('11:00', 'HH24:MI'),
 TO_DATE('12:00', 'HH24:MI'),
 35, 'Rainy', 'SCHEDULED',
 TO_DATE('2025-08-01', 'YYYY-MM-DD'));

INSERT INTO Experience_Session
(Session_Id, Package_Id, Event_Id, Venue_Id,
 Session_Date, Start_Time, End_Time,
 Available_Slots, Weather_Condition, Status, Created_Date)
VALUES
('S027', 'VP007', 'RE007', 'V009',
 TO_DATE('2025-10-10', 'YYYY-MM-DD'),
 TO_DATE('13:00', 'HH24:MI'),
 TO_DATE('14:00', 'HH24:MI'),
 14, 'Sunny', 'SCHEDULED',
 TO_DATE('2025-08-01', 'YYYY-MM-DD'));

INSERT INTO Experience_Session
(Session_Id, Package_Id, Event_Id, Venue_Id,
 Session_Date, Start_Time, End_Time,
 Available_Slots, Weather_Condition, Status, Created_Date)
VALUES
('S028', 'VP008', 'RE008', 'V010',
 TO_DATE('2025-10-11', 'YYYY-MM-DD'),
 TO_DATE('14:30', 'HH24:MI'),
 TO_DATE('15:30', 'HH24:MI'),
 33, 'Windy', 'SCHEDULED',
 TO_DATE('2025-08-01', 'YYYY-MM-DD'));

INSERT INTO Experience_Session
(Session_Id, Package_Id, Event_Id, Venue_Id,
 Session_Date, Start_Time, End_Time,
 Available_Slots, Weather_Condition, Status, Created_Date)
VALUES
('S029', 'VP009', 'RE009', 'V001',
 TO_DATE('2025-10-12', 'YYYY-MM-DD'),
 TO_DATE('09:30', 'HH24:MI'),
 TO_DATE('10:30', 'HH24:MI'),
 35, 'Rainy', 'SCHEDULED',
 TO_DATE('2025-08-01', 'YYYY-MM-DD'));

INSERT INTO Experience_Session
(Session_Id, Package_Id, Event_Id, Venue_Id,
 Session_Date, Start_Time, End_Time,
 Available_Slots, Weather_Condition, Status, Created_Date)
VALUES
('S030', 'VP010', 'RE010', 'V002',
 TO_DATE('2025-10-12', 'YYYY-MM-DD'),
 TO_DATE('11:00', 'HH24:MI'),
 TO_DATE('12:00', 'HH24:MI'),
 19, 'Sunny', 'SCHEDULED',
 TO_DATE('2025-08-01', 'YYYY-MM-DD'));

-- Insert 30 rows into Hospitality_Staff

INSERT INTO Hospitality_Staff
(Staff_Id, First_Name, Last_Name, Capacity,
 First_Language, Second_Language,
 Experience_Level, Availability_Status, Rating)
VALUES
('HS001', 'Alice', 'Smith', 50,
 'English', 'Spanish',
 'Senior', 'AVAILABLE', 4);
INSERT INTO Hospitality_Staff
(Staff_Id, First_Name, Last_Name, Capacity,
 First_Language, Second_Language,
 Experience_Level, Availability_Status, Rating)
VALUES
('HS002', 'Bob',      'Johnson',  40,
 'English', 'French',
 'Advanced', 'AVAILABLE',   3);
INSERT INTO Hospitality_Staff
(Staff_Id, First_Name, Last_Name, Capacity,
 First_Language, Second_Language,
 Experience_Level, Availability_Status, Rating)
VALUES
('HS003', 'Clara',    'Williams', 30,
 'Spanish', 'English',
 'Junior',   'UNAVAILABLE', 3);
INSERT INTO Hospitality_Staff
(Staff_Id, First_Name, Last_Name, Capacity,
 First_Language, Second_Language,
 Experience_Level, Availability_Status, Rating)
VALUES
('HS004', 'David',    'Brown',    20,
 'English', 'German',
 'Senior',   'AVAILABLE',   5);
INSERT INTO Hospitality_Staff
(Staff_Id, First_Name, Last_Name, Capacity,
 First_Language, Second_Language,
 Experience_Level, Availability_Status, Rating)
VALUES
('HS005', 'Eva', 'Davis', 45,
 'French', 'English',
 'Advanced', 'UNAVAILABLE', 2);
INSERT INTO Hospitality_Staff
(Staff_Id, First_Name, Last_Name, Capacity,
 First_Language, Second_Language,
 Experience_Level, Availability_Status, Rating)
VALUES
('HS006', 'Frank',    'Lee',      30,
 'English', 'Japanese',
 'Senior',   'AVAILABLE',   5);
INSERT INTO Hospitality_Staff
(Staff_Id, First_Name, Last_Name, Capacity,
 First_Language, Second_Language,
 Experience_Level, Availability_Status, Rating)
VALUES
('HS007', 'Grace',   'Kim',     25,
 'Korean', 'English',
 'Junior',    'UNAVAILABLE',  3);
INSERT INTO Hospitality_Staff
(Staff_Id, First_Name, Last_Name, Capacity,
 First_Language, Second_Language,
 Experience_Level, Availability_Status, Rating)
VALUES
('HS009', 'Irene',   'Lopez',   28,
 'English', 'Mandarin',
 'Intermediate', 'UNAVAILABLE', 4);
INSERT INTO Hospitality_Staff
(Staff_Id, First_Name, Last_Name, Capacity,
 First_Language, Second_Language,
 Experience_Level, Availability_Status, Rating)
VALUES
('HS010', 'Jack',    'Lopez',    40,
 'English', 'Portuguese',
 'Senior',    'AVAILABLE',   5);
INSERT INTO Hospitality_Staff
(Staff_Id, First_Name, Last_Name, Capacity,
 First_Language, Second_Language,
 Experience_Level, Availability_Status, Rating)
VALUES
('HS011', 'Karen',   'Patel',    32,
 'Hindi',   'English',
 'Advanced', 'UNAVAILABLE', 3);
INSERT INTO Hospitality_Staff
(Staff_Id, First_Name, Last_Name, Capacity,
 First_Language, Second_Language,
 Experience_Level, Availability_Status, Rating)
VALUES
('HS012', 'Leon',    'Wong',     27,
 'Cantonese', 'English',
 'Junior',    'AVAILABLE',   2);
INSERT INTO Hospitality_Staff
(Staff_Id, First_Name, Last_Name, Capacity,
 First_Language, Second_Language,
 Experience_Level, Availability_Status, Rating)
VALUES
('HS013', 'Mia',     'Garcia',   45,
 'Spanish',  'English',
 'Senior',   'AVAILABLE',   5);
INSERT INTO Hospitality_Staff
(Staff_Id, First_Name, Last_Name, Capacity,
 First_Language, Second_Language,
 Experience_Level, Availability_Status, Rating)
VALUES
('HS014', 'Nate',    'Singh',    38,
 'Punjabi',  'Hindi',
 'Advanced', 'UNAVAILABLE', 4);
INSERT INTO Hospitality_Staff
(Staff_Id, First_Name, Last_Name, Capacity,
 First_Language, Second_Language,
 Experience_Level, Availability_Status, Rating)
VALUES
('HS015', 'Olivia',  'Martinez', 50,
 'English', 'Spanish',
 'Intermediate', 'AVAILABLE', 4);
INSERT INTO Hospitality_Staff
(Staff_Id, First_Name, Last_Name, Capacity,
 First_Language, Second_Language,
 Experience_Level, Availability_Status, Rating)
VALUES
('HS016', 'Peter',   'Wilson',  25,
 'English', 'Arabic',
 'Junior',    'AVAILABLE',   3);
INSERT INTO Hospitality_Staff
(Staff_Id, First_Name, Last_Name, Capacity,
 First_Language, Second_Language,
 Experience_Level, Availability_Status, Rating)
VALUES
('HS017', 'Rachel',  'Adams',   30,
 'English', 'German',
 'Advanced',  'UNAVAILABLE', 4);
INSERT INTO Hospitality_Staff
(Staff_Id, First_Name, Last_Name, Capacity,
 First_Language, Second_Language,
 Experience_Level, Availability_Status, Rating)
VALUES
('HS018', 'Samuel',  'Young',   35,
 'Mandarin', 'English',
 'Senior',    'AVAILABLE',   5);
INSERT INTO Hospitality_Staff
(Staff_Id, First_Name, Last_Name, Capacity,
 First_Language, Second_Language,
 Experience_Level, Availability_Status, Rating)
VALUES
('HS019', 'Tina',    'Scott',   40,
 'English', 'Portuguese',
 'Intermediate', 'UNAVAILABLE', 4);
INSERT INTO Hospitality_Staff
(Staff_Id, First_Name, Last_Name, Capacity,
 First_Language, Second_Language,
 Experience_Level, Availability_Status, Rating)
VALUES
('HS020', 'Umar',    'Hassan',  45,
 'Arabic', 'English',
 'Junior',    'AVAILABLE',   2);
INSERT INTO Hospitality_Staff
(Staff_Id, First_Name, Last_Name, Capacity,
 First_Language, Second_Language,
 Experience_Level, Availability_Status, Rating)
VALUES
('HS021', 'Victor', 'Chen', 28,
 'English', 'Mandarin',
 'Senior', 'AVAILABLE', 5);
INSERT INTO Hospitality_Staff
(Staff_Id, First_Name, Last_Name, Capacity,
 First_Language, Second_Language,
 Experience_Level, Availability_Status, Rating)
VALUES
('HS022', 'Wendy', 'Zhang', 32,
 'Mandarin', 'English',
 'Advanced', 'UNAVAILABLE', 3);
INSERT INTO Hospitality_Staff
(Staff_Id, First_Name, Last_Name, Capacity,
 First_Language, Second_Language,
 Experience_Level, Availability_Status, Rating)
VALUES
('HS023', 'Xander', 'Clark', 27,
 'English', 'Spanish',
 'Junior', 'AVAILABLE', 2);
INSERT INTO Hospitality_Staff
(Staff_Id, First_Name, Last_Name, Capacity,
 First_Language, Second_Language,
 Experience_Level, Availability_Status, Rating)
VALUES
('HS024', 'Yasmin', 'Khan', 30,
 'Arabic', 'English',
 'Intermediate', 'AVAILABLE', 4);
INSERT INTO Hospitality_Staff
(Staff_Id, First_Name, Last_Name, Capacity,
 First_Language, Second_Language,
 Experience_Level, Availability_Status, Rating)
VALUES
('HS025', 'Zoe', 'Taylor', 26,
 'English', 'French',
 'Senior', 'UNAVAILABLE', 5);
INSERT INTO Hospitality_Staff
(Staff_Id, First_Name, Last_Name, Capacity,
 First_Language, Second_Language,
 Experience_Level, Availability_Status, Rating)
VALUES
('HS026', 'Aaron',   'Ng',      33,
 'Cantonese', 'English',
 'Advanced', 'AVAILABLE', 4);
INSERT INTO Hospitality_Staff
(Staff_Id, First_Name, Last_Name, Capacity,
 First_Language, Second_Language,
 Experience_Level, Availability_Status, Rating)
VALUES
('HS027', 'Bianca',  'Lopez',   29,
 'Spanish', 'English',
 'Junior',   'UNAVAILABLE', 3);
INSERT INTO Hospitality_Staff
(Staff_Id, First_Name, Last_Name, Capacity,
 First_Language, Second_Language,
 Experience_Level, Availability_Status, Rating)
VALUES
('HS028', 'Carlos',  'Evans',   37,
 'English', 'Mandarin',
 'Senior',   'AVAILABLE', 5);
INSERT INTO Hospitality_Staff
(Staff_Id, First_Name, Last_Name, Capacity,
 First_Language, Second_Language,
 Experience_Level, Availability_Status, Rating)
VALUES
('HS029', 'Diana',   'Wright',  42,
 'English', 'French',
 'Intermediate', 'UNAVAILABLE', 2);
INSERT INTO Hospitality_Staff
(Staff_Id, First_Name, Last_Name, Capacity,
 First_Language, Second_Language,
 Experience_Level, Availability_Status, Rating)
VALUES
('HS030', 'Ethan',   'Hall',    31,
 'English', 'Japanese',
 'Junior',   'AVAILABLE', 4);

-- Insert 30 rows into Vip_Guest

INSERT INTO VIP_Guest
(Guest_Id, First_Name, Last_Name, Membership_Rank, Carbon_Credits)
VALUES
('VG001', 'Alice',   'Wang',     'Gold',     120);

INSERT INTO VIP_Guest
(Guest_Id, First_Name, Last_Name, Membership_Rank, Carbon_Credits)
VALUES
('VG002', 'Brad',    'Jones',    'Silver',    80);

INSERT INTO VIP_Guest
(Guest_Id, First_Name, Last_Name, Membership_Rank, Carbon_Credits)
VALUES
('VG003', 'Cathy',   'Li',       'Bronze',    60);

INSERT INTO VIP_Guest
(Guest_Id, First_Name, Last_Name, Membership_Rank, Carbon_Credits)
VALUES
('VG004', 'Daniel',  'Kim',      'Gold',     150);

INSERT INTO VIP_Guest
(Guest_Id, First_Name, Last_Name, Membership_Rank, Carbon_Credits)
VALUES
('VG005', 'Eva',     'Davis',    'Silver',    90);

INSERT INTO VIP_Guest
(Guest_Id, First_Name, Last_Name, Membership_Rank, Carbon_Credits)
VALUES
('VG006', 'Frank',   'Lee',      'Platinum', 200);

INSERT INTO VIP_Guest
(Guest_Id, First_Name, Last_Name, Membership_Rank, Carbon_Credits)
VALUES
('VG007', 'Grace',   'Kim',      'Gold',     130);

INSERT INTO VIP_Guest
(Guest_Id, First_Name, Last_Name, Membership_Rank, Carbon_Credits)
VALUES
('VG008', 'Hannah',  'Nguyen',   'Bronze',    70);

INSERT INTO VIP_Guest
(Guest_Id, First_Name, Last_Name, Membership_Rank, Carbon_Credits)
VALUES
('VG009', 'Irene',   'Lopez',    'Silver',    85);

INSERT INTO VIP_Guest
(Guest_Id, First_Name, Last_Name, Membership_Rank, Carbon_Credits)
VALUES
('VG010', 'Jack',    'Hall',     'Gold',     140);

INSERT INTO VIP_Guest
(Guest_Id, First_Name, Last_Name, Membership_Rank, Carbon_Credits)
VALUES
('VG011', 'Karen',   'Patel',    'Bronze',    65);

INSERT INTO VIP_Guest
(Guest_Id, First_Name, Last_Name, Membership_Rank, Carbon_Credits)
VALUES
('VG012', 'Leon',    'Wong',     'Silver',    95);

INSERT INTO VIP_Guest
(Guest_Id, First_Name, Last_Name, Membership_Rank, Carbon_Credits)
VALUES
('VG013', 'Mia',     'Garcia',   'Gold',     145);

INSERT INTO VIP_Guest
(Guest_Id, First_Name, Last_Name, Membership_Rank, Carbon_Credits)
VALUES
('VG014', 'Nate',    'Singh',    'Silver',    88);

INSERT INTO VIP_Guest
(Guest_Id, First_Name, Last_Name, Membership_Rank, Carbon_Credits)
VALUES
('VG015', 'Olivia',  'Martinez', 'Bronze',    55);

INSERT INTO VIP_Guest
(Guest_Id, First_Name, Last_Name, Membership_Rank, Carbon_Credits)
VALUES
('VG016', 'Alice',   'Brown',    'Platinum', 180);

INSERT INTO VIP_Guest
(Guest_Id, First_Name, Last_Name, Membership_Rank, Carbon_Credits)
VALUES
('VG017', 'Bob',     'Smith',    'Gold',     135);

INSERT INTO VIP_Guest
(Guest_Id, First_Name, Last_Name, Membership_Rank, Carbon_Credits)
VALUES
('VG018', 'Clara',   'Weber',    'Silver',   100);

INSERT INTO VIP_Guest
(Guest_Id, First_Name, Last_Name, Membership_Rank, Carbon_Credits)
VALUES
('VG019', 'David',   'Chen',     'Platinum', 190);

INSERT INTO VIP_Guest
(Guest_Id, First_Name, Last_Name, Membership_Rank, Carbon_Credits)
VALUES
('VG020', 'Emma',    'Clark',    'Gold',     125);

INSERT INTO VIP_Guest
(Guest_Id, First_Name, Last_Name, Membership_Rank, Carbon_Credits)
VALUES
('VG021', 'Frank',   'Lin',      'Silver',   105);

INSERT INTO VIP_Guest
(Guest_Id, First_Name, Last_Name, Membership_Rank, Carbon_Credits)
VALUES
('VG022', 'Grace',   'Lim',      'Bronze',    75);

INSERT INTO VIP_Guest
(Guest_Id, First_Name, Last_Name, Membership_Rank, Carbon_Credits)
VALUES
('VG023', 'Hannah',  'Rossi',    'Gold',     160);

INSERT INTO VIP_Guest
(Guest_Id, First_Name, Last_Name, Membership_Rank, Carbon_Credits)
VALUES
('VG024', 'Ian',     'Thompson', 'Platinum', 170);

INSERT INTO VIP_Guest
(Guest_Id, First_Name, Last_Name, Membership_Rank, Carbon_Credits)
VALUES
('VG025', 'Jill',    'Martinez', 'Silver',   115);

INSERT INTO VIP_Guest
(Guest_Id, First_Name, Last_Name, Membership_Rank, Carbon_Credits)
VALUES
('VG026', 'Kevin',   'Patel',    'Bronze',    58);

INSERT INTO VIP_Guest
(Guest_Id, First_Name, Last_Name, Membership_Rank, Carbon_Credits)
VALUES
('VG027', 'Linda',   'Muller',   'Silver',    92);

INSERT INTO VIP_Guest
(Guest_Id, First_Name, Last_Name, Membership_Rank, Carbon_Credits)
VALUES
('VG028', 'Mark',    'Davies',   'Gold',     155);

INSERT INTO VIP_Guest
(Guest_Id, First_Name, Last_Name, Membership_Rank, Carbon_Credits)
VALUES
('VG029', 'Nina',    'Lopez',    'Bronze',    68);

INSERT INTO VIP_Guest
(Guest_Id, First_Name, Last_Name, Membership_Rank, Carbon_Credits)
VALUES
('VG030', 'Oscar',   'Silva',    'Platinum', 175);

-- Insert 15 rows into Individual_Guest
INSERT INTO Individual_Guest
(Guest_Id, Date_Of_Birth, Nationality, Email, Phone_Number)
VALUES
('VG001', TO_DATE('1985-04-12','YYYY-MM-DD'),
 'Australia',    'alice.wang@gmail.com',       '+61 400 123 456');

INSERT INTO Individual_Guest
(Guest_Id, Date_Of_Birth, Nationality, Email, Phone_Number)
VALUES
('VG002', TO_DATE('1992-07-30','YYYY-MM-DD'),
 'USA',          'brad.jones@yahoo.com',       '+1 401-234-5678');

INSERT INTO Individual_Guest
(Guest_Id, Date_Of_Birth, Nationality, Email, Phone_Number)
VALUES
('VG003', TO_DATE('1978-11-05','YYYY-MM-DD'),
 'China',        'cathy.li@outlook.com',       '+86 178 1869 2165');

INSERT INTO Individual_Guest
(Guest_Id, Date_Of_Birth, Nationality, Email, Phone_Number)
VALUES
('VG004', TO_DATE('1989-01-20','YYYY-MM-DD'),
 'South Korea', 'daniel.kim@live.com',        '+82 10-2345-6789');

INSERT INTO Individual_Guest
(Guest_Id, Date_Of_Birth, Nationality, Email, Phone_Number)
VALUES
('VG005', TO_DATE('1995-06-17','YYYY-MM-DD'),
 'UK',           'eva.davis@gmail.com',        '+44 7700 900123');

INSERT INTO Individual_Guest
(Guest_Id, Date_Of_Birth, Nationality, Email, Phone_Number)
VALUES
('VG006', TO_DATE('1982-09-25','YYYY-MM-DD'),
 'Canada',      'frank.lee@icloud.com',        '+1 416-678-9012');

INSERT INTO Individual_Guest
(Guest_Id, Date_Of_Birth, Nationality, Email, Phone_Number)
VALUES
('VG007', TO_DATE('1990-03-08','YYYY-MM-DD'),
 'Singapore',   'grace.kim@yahoo.com',         '+65 9123 4567');

INSERT INTO Individual_Guest
(Guest_Id, Date_Of_Birth, Nationality, Email, Phone_Number)
VALUES
('VG008', TO_DATE('1987-12-14','YYYY-MM-DD'),
 'Vietnam',     'hannah.nguyen@hotmail.com',   '+84 912 345 678');

INSERT INTO Individual_Guest
(Guest_Id, Date_Of_Birth, Nationality, Email, Phone_Number)
VALUES
('VG009', TO_DATE('1993-05-22','YYYY-MM-DD'),
 'Spain',       'irene.lopez@gmail.com',       '+34 612 345 678');

INSERT INTO Individual_Guest
(Guest_Id, Date_Of_Birth, Nationality, Email, Phone_Number)
VALUES
('VG010', TO_DATE('1980-08-03','YYYY-MM-DD'),
 'USA',         'jack.hall@outlook.com',       '+1 310-555-0123');

INSERT INTO Individual_Guest
(Guest_Id, Date_Of_Birth, Nationality, Email, Phone_Number)
VALUES
('VG011', TO_DATE('1988-02-11','YYYY-MM-DD'),
 'India',       'karen.patel@gmail.com',       '+91 98765 43210');

INSERT INTO Individual_Guest
(Guest_Id, Date_Of_Birth, Nationality, Email, Phone_Number)
VALUES
('VG012', TO_DATE('1991-10-29','YYYY-MM-DD'),
 'China',       'leon.wong@yahoo.com',         '+86 139 1234 5678');

INSERT INTO Individual_Guest
(Guest_Id, Date_Of_Birth, Nationality, Email, Phone_Number)
VALUES
('VG013', TO_DATE('1983-07-06','YYYY-MM-DD'),
 'USA',         'mia.garcia@protonmail.com',   '+1 212-555-6789');

INSERT INTO Individual_Guest
(Guest_Id, Date_Of_Birth, Nationality, Email, Phone_Number)
VALUES
('VG014', TO_DATE('1975-11-19','YYYY-MM-DD'),
 'Australia',    'nate.singh@gmail.com',       '+61 410 987 654');

INSERT INTO Individual_Guest
(Guest_Id, Date_Of_Birth, Nationality, Email, Phone_Number)
VALUES
('VG015', TO_DATE('1994-03-23','YYYY-MM-DD'),
 'Brazil',       'olivia.martinez@hotmail.com', '+55 21 91234 5678');

-- Insert 15 rows into Corporation_Guest

INSERT INTO Corporate_Guest
(Guest_Id, Company_Name, Job_Title, Department, Expense_Account_Code, Corporate_Email)
VALUES
('VG016', 'EcoMotors Ltd',    'VP Operations',            'Operations',              'ACC-2001', 'vp.ops@ecomotors.com');

INSERT INTO Corporate_Guest
(Guest_Id, Company_Name, Job_Title, Department, Expense_Account_Code, Corporate_Email)
VALUES
('VG017', 'VoltEnergy Inc',   'Operations Manager',       'Operations',              'ACC-2002', 'ops.manager@voltenergy.com');

INSERT INTO Corporate_Guest
(Guest_Id, Company_Name, Job_Title, Department, Expense_Account_Code, Corporate_Email)
VALUES
('VG018', 'GreenCharge GmbH', 'Chief Technology Officer', 'Technology',              'ACC-2003', 'cto@greencharge.de');

INSERT INTO Corporate_Guest
(Guest_Id, Company_Name, Job_Title, Department, Expense_Account_Code, Corporate_Email)
VALUES
('VG019', 'SunPower Co',      'Chief Financial Officer',  'Finance',                 'ACC-2004', 'cfo@sunpower.com.au');

INSERT INTO Corporate_Guest
(Guest_Id, Company_Name, Job_Title, Department, Expense_Account_Code, Corporate_Email)
VALUES
('VG020', 'ChargeUp Pty',     'Human Resources Director', 'Human Resources',         'ACC-2005', 'hr.dir@chargeup.com.au');

INSERT INTO Corporate_Guest
(Guest_Id, Company_Name, Job_Title, Department, Expense_Account_Code, Corporate_Email)
VALUES
('VG021', 'Voltix Corp',      'Chief Executive Officer',  'Executive',               'ACC-2006', 'ceo@voltix.com');

INSERT INTO Corporate_Guest
(Guest_Id, Company_Name, Job_Title, Department, Expense_Account_Code, Corporate_Email)
VALUES
('VG022', 'PowerFlow LLC',    'IT Lead',                  'Information Technology',  'ACC-2007', 'itlead@powerflow.com');

INSERT INTO Corporate_Guest
(Guest_Id, Company_Name, Job_Title, Department, Expense_Account_Code, Corporate_Email)
VALUES
('VG023', 'ElectroDrive SA',  'Marketing Head',           'Marketing',               'ACC-2008', 'marketing@electrodrive.fr');

INSERT INTO Corporate_Guest
(Guest_Id, Company_Name, Job_Title, Department, Expense_Account_Code, Corporate_Email)
VALUES
('VG024', 'AmpereTech Ltd',   'Chief Operating Officer',  'Operations',              'ACC-2009', 'coo@amperetech.ca');

INSERT INTO Corporate_Guest
(Guest_Id, Company_Name, Job_Title, Department, Expense_Account_Code, Corporate_Email)
VALUES
('VG025', 'GreenGrid Inc',    'Supply Chain Manager',     'Logistics',               'ACC-2010', 'scm@greengrid.es');

INSERT INTO Corporate_Guest
(Guest_Id, Company_Name, Job_Title, Department, Expense_Account_Code, Corporate_Email)
VALUES
('VG026', 'EcoCharge Co',     'Procurement Head',         'Procurement',             'ACC-2011', 'procurement@ecocharge.ae');

INSERT INTO Corporate_Guest
(Guest_Id, Company_Name, Job_Title, Department, Expense_Account_Code, Corporate_Email)
VALUES
('VG027', 'SparkWorks AG',    'Research Director',        'Research and Development','ACC-2012', 'research@sparkworks.ch');

INSERT INTO Corporate_Guest
(Guest_Id, Company_Name, Job_Title, Department, Expense_Account_Code, Corporate_Email)
VALUES
('VG028', 'ChargeNet PLC',    'Network Architect',        'Engineering',             'ACC-2013', 'network@chargenet.co.uk');

INSERT INTO Corporate_Guest
(Guest_Id, Company_Name, Job_Title, Department, Expense_Account_Code, Corporate_Email)
VALUES
('VG029', 'EcoVolt SA',       'Compliance Officer',       'Compliance',              'ACC-2014', 'compliance@ecovolt.mx');

INSERT INTO Corporate_Guest
(Guest_Id, Company_Name, Job_Title, Department, Expense_Account_Code, Corporate_Email)
VALUES
('VG030', 'PowerGen Ltd',     'Legal Counsel',            'Legal',                   'ACC-2015', 'legal@powergen.br');

--Booking_id Records--
INSERT INTO Booking
  (Booking_Id, Session_Id, Booking_Capacity, Total_Amount,
   Booking_Description, Booking_Status, Booking_Channel, IP_Address)
VALUES
  ('B001','S001',1,100,'Auto‐generated B001','CONFIRMED','ONLINE','0.0.0.0');
VALUES
  ('B002','S002',1,100,'Auto-generated B002','CONFIRMED','ONLINE','0.0.0.0');

VALUES
  ('B003','S003',1,100,'Auto-generated B003','CONFIRMED','ONLINE','0.0.0.0');

INSERT INTO Booking
VALUES
  ('B004','S004',1,100,'Auto-generated B004','CONFIRMED','ONLINE','0.0.0.0');

INSERT INTO Booking
VALUES
  ('B005','S005',1,100,'Auto-generated B005','CONFIRMED','ONLINE','0.0.0.0');

INSERT INTO Booking
VALUES
  ('B006','S006',1,100,'Auto-generated B006','CONFIRMED','ONLINE','0.0.0.0');

INSERT INTO Booking
VALUES
  ('B007','S007',1,100,'Auto-generated B007','CONFIRMED','ONLINE','0.0.0.0');

INSERT INTO Booking
VALUES
  ('B008','S008',1,100,'Auto-generated B008','CONFIRMED','ONLINE','0.0.0.0');

INSERT INTO Booking
VALUES
  ('B009','S009',1,100,'Auto-generated B009','CONFIRMED','ONLINE','0.0.0.0');

INSERT INTO Booking
VALUES
  ('B010','S010',1,100,'Auto-generated B010','CONFIRMED','ONLINE','0.0.0.0');

INSERT INTO Booking
VALUES
  ('B011','S011',1,100,'Auto-generated B011','CONFIRMED','ONLINE','0.0.0.0');

INSERT INTO Booking
VALUES
  ('B012','S012',1,100,'Auto-generated B012','CONFIRMED','ONLINE','0.0.0.0');

INSERT INTO Booking
VALUES
  ('B013','S013',1,100,'Auto-generated B013','CONFIRMED','ONLINE','0.0.0.0');

INSERT INTO Booking
VALUES
  ('B014','S014',1,100,'Auto-generated B014','CONFIRMED','ONLINE','0.0.0.0');

INSERT INTO Booking
VALUES
  ('B015','S015',1,100,'Auto-generated B015','CONFIRMED','ONLINE','0.0.0.0');

INSERT INTO Booking
VALUES
  ('B016','S016',1,100,'Auto-generated B016','CONFIRMED','ONLINE','0.0.0.0');

INSERT INTO Booking
VALUES
  ('B017','S017',1,100,'Auto-generated B017','CONFIRMED','ONLINE','0.0.0.0');

INSERT INTO Booking
VALUES
  ('B018','S018',1,100,'Auto-generated B018','CONFIRMED','ONLINE','0.0.0.0');

INSERT INTO Booking
VALUES
  ('B019','S019',1,100,'Auto-generated B019','CONFIRMED','ONLINE','0.0.0.0');

INSERT INTO Booking
VALUES
  ('B020','S020',1,100,'Auto-generated B020','CONFIRMED','ONLINE','0.0.0.0');

INSERT INTO Booking
VALUES
  ('B021','S021',1,100,'Auto-generated B021','CONFIRMED','ONLINE','0.0.0.0');

INSERT INTO Booking
VALUES
  ('B022','S022',1,100,'Auto-generated B022','CONFIRMED','ONLINE','0.0.0.0');

INSERT INTO Booking
VALUES
  ('B023','S023',1,100,'Auto-generated B023','CONFIRMED','ONLINE','0.0.0.0');

INSERT INTO Booking
VALUES
  ('B024','S024',1,100,'Auto-generated B024','CONFIRMED','ONLINE','0.0.0.0');

INSERT INTO Booking
VALUES
  ('B025','S025',1,100,'Auto-generated B025','CONFIRMED','ONLINE','0.0.0.0');

INSERT INTO Booking
VALUES
  ('B026','S026',1,100,'Auto-generated B026','CONFIRMED','ONLINE','0.0.0.0');

INSERT INTO Booking
VALUES
  ('B027','S027',1,100,'Auto-generated B027','CONFIRMED','ONLINE','0.0.0.0');

INSERT INTO Booking
VALUES
  ('B028','S028',1,100,'Auto-generated B028','CONFIRMED','ONLINE','0.0.0.0');

INSERT INTO Booking
VALUES
  ('B029','S029',1,100,'Auto-generated B029','CONFIRMED','ONLINE','0.0.0.0');

INSERT INTO Booking
VALUES
  ('B030','S030',1,100,'Auto-generated B030','CONFIRMED','ONLINE','0.0.0.0');

COMMIT;
--30 Individual Booking_Guest Records matching VIP Guest entries--

INSERT INTO Booking_Guest
  (Booking_Id, Guest_Id, Is_Primary, Dietary_Requirements, Special_Needs, Allergies,
   Check_In_Status, Check_In_Time, Created_Date)
 VALUES
  ('B001','S001',4,380,'Family group of 4','CONFIRMED','PHONE','3.5.140.1');      
INSERT INTO Booking (Booking_Id, Session_Id, Guest_Count, Total_Amount,Booking_Description, Booking_Status, Booking_Channel, IP_Address)
VALUES
  ('B001','S001',1832,'Solo traveler','PENDING','ONLINE','13.229.188.59');       
INSERT INTO Booking   
VALUES
('B002', 'S002',1832, 'Solo traveler', 'PENDING', 'ONLINE', '13.229.188.59');

INSERT INTO Booking
VALUES
  ('B003','S003',7840,'Corporate offsite','CONFIRMED','IN_PERSON','51.15.0.21'); 

INSERT INTO Booking
VALUES
  ('B004','S004',3270,'Friends reunion','CANCELLED','OTHER','81.2.69.142');      

INSERT INTO Booking
VALUES
  ('B005','S005',2210,'Couple package','NO_SHOW','ONLINE','203.119.158.74');    

INSERT INTO Booking
VALUES
  ('B006','S006',5600,'Team-building','CONFIRMED','AGENCY','1.1.1.1');          

INSERT INTO Booking
VALUES
  ('B007','S007',6660,'Conference group','PENDING','IN_PERSON','210.140.60.128');

INSERT INTO Booking
VALUES
  ('B008','S008',8960,'Large family','CONFIRMED','PHONE','196.40.14.3');        

INSERT INTO Booking
VALUES
  ('B09','S09',4420,'Weekend getaway','CONFIRMED','ONLINE','5.44.34.15');      

INSERT INTO Booking
VALUES
  ('B010','S010',91170,'VIP delegation','PENDING','OTHER','23.236.62.147');     

INSERT INTO Booking
VALUES
  ('B011','S011',1832,'Anniversary special','CONFIRMED','IN_PERSON','194.26.1.1');

INSERT INTO Booking
VALUES
  ('B012','S012',3,315,'Business meeting','CANCELLED','PHONE','200.49.152.10');  

INSERT INTO Booking
VALUES
  ('B013','S013',1130,'Solo deluxe','CONFIRMED','ONLINE','185.199.108.153');   

INSERT INTO Booking
VALUES
  ('B014','S014',5,550,'Workshop attendees','PENDING','AGENCY','103.21.244.0'); 

INSERT INTO Booking
VALUES
  ('B015','S015',7,770,'Conference speakers','CONFIRMED','IN_PERSON','31.13.71.36'); 

INSERT INTO Booking
VALUES
  ('B016','S016',1832,'Parent and child','NO_SHOW','ONLINE','64.233.160.0');     

INSERT INTO Booking
VALUES
  ('B017','S017',4,440,'Friend trip','CONFIRMED','PHONE','89.248.172.10');       

INSERT INTO Booking
VALUES
  ('B018','S018',6,630,'Extended family','PENDING','OTHER','104.244.42.1');     

INSERT INTO Booking
VALUES
  ('B019','S019',3305,'Group tour','CONFIRMED','IN_PERSON','216.58.214.14');    

INSERT INTO Booking
VALUES
  ('B020','S020',8880,'Charity event','CONFIRMED','AGENCY','13.35.21.18');      

INSERT INTO Booking
VALUES
  ('B021','S021',1832,'Solo budget','PENDING','ONLINE','203.80.0.1');          

INSERT INTO Booking
VALUES
  ('B022','S022',9990,'Holiday group','CONFIRMED','PHONE','103.10.124.0');     

INSERT INTO Booking
VALUES
  ('B023','S023',5525,'Retreat participants','NO_SHOW','IN_PERSON','185.60.112.157'); 

INSERT INTO Booking
VALUES
  ('B024','S024',1832,'Short stay','CONFIRMED','OTHER','20.13.1.10');           

INSERT INTO Booking
VALUES
  ('B025','S025',4410,'Weekend package','PENDING','AGENCY','213.186.33.5');    

INSERT INTO Booking
VALUES
  ('B026','S026',7700,'Education seminar','CONFIRMED','ONLINE','52.58.136.7');  

INSERT INTO Booking
VALUES
  ('B027','S027',3315,'Friends special','CANCELLED','PHONE','185.60.112.8');    

INSERT INTO Booking
VALUES
  ('B028','S028',6645,'Family deluxe','CONFIRMED','IN_PERSON','172.217.5.110'); 

INSERT INTO Booking
VALUES
  ('B029','S029',1832,'Couple retreat','CONFIRMED','ONLINE','142.250.64.78');  

INSERT INTO Booking
VALUES
  ('B030', 'S030', 3180, 'Green Grid Lounge', 'CONFIRMED', 'ONLINE','95.73.41.113');

COMMIT;

--Insert payment record for Booking--

INSERT INTO Payment (Payment_Id, Booking_Id, Payment_Amount, Payment_Date_Time, Payment_Reference_Number, Payment_Status)
VALUES ('P001', 'B001', 1832, TO_TIMESTAMP('2025-06-02 10:00:48', 'YYYY-MM-DD HH24:MI:SS'), 'REF356787', 'COMPLETED');

INSERT INTO Payment 
VALUES ('P002', 'B002', 1832, TO_TIMESTAMP('2025-07-09 15:26:01', 'YYYY-MM-DD HH24:MI:SS'),'REF617263', 'PENDING');

INSERT INTO Payment 
VALUES ('P003', 'B003', 2647, TO_TIMESTAMP('2025-07-09 15:26:01', 'YYYY-MM-DD HH24:MI:SS'), 'REF617263', 'PENDING');

INSERT INTO Payment  
VALUES ('P004', 'B004', 3270, TO_TIMESTAMP('2025-07-04 14:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'REF312784', 'FAILED');

INSERT INTO Payment   
VALUES ('P005', 'B005', 2210, TO_TIMESTAMP('2025-07-05 09:42:00', 'YYYY-MM-DD HH24:MI:SS'), 'REF987321', 'PENDING');

INSERT INTO Payment   
VALUES ('P006', 'B006', 5600, TO_TIMESTAMP('2025-07-06 13:58:00', 'YYYY-MM-DD HH24:MI:SS'), 'REF456109', 'COMPLETED');

INSERT INTO Payment   
VALUES ('P007', 'B007', 6660, TO_TIMESTAMP('2025-07-07 15:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'REF209834', 'PENDING');

INSERT INTO Payment 
VALUES ('P008', 'B008', 8960, TO_TIMESTAMP('2025-07-08 11:05:00', 'YYYY-MM-DD HH24:MI:SS'), 'REF673920', 'COMPLETED');

INSERT INTO Payment 
VALUES ('P009', 'B009', 4420, TO_TIMESTAMP('2025-07-09 10:47:00', 'YYYY-MM-DD HH24:MI:SS'), 'REF118493', 'FAILED');

INSERT INTO Payment  
VALUES ('P010', 'B010', 91170, TO_TIMESTAMP('2025-07-10 12:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'REF736204', 'PENDING');

INSERT INTO Payment  
VALUES ('P011', 'B011', 1832, TO_TIMESTAMP('2025-07-11 09:35:00', 'YYYY-MM-DD HH24:MI:SS'), 'REF849370', 'COMPLETED');

INSERT INTO Payment  
VALUES ('P012', 'B012', 315, TO_TIMESTAMP('2025-07-12 14:10:00', 'YYYY-MM-DD HH24:MI:SS'), 'REF905612', 'FAILED');

INSERT INTO Payment  
VALUES ('P013', 'B013', 1130, TO_TIMESTAMP('2025-07-13 11:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'REF328741', 'COMPLETED');

INSERT INTO Payment  
VALUES ('P014', 'B014', 550, TO_TIMESTAMP('2025-07-14 16:25:00', 'YYYY-MM-DD HH24:MI:SS'), 'REF772983', 'PENDING');

INSERT INTO Payment  
VALUES ('P015', 'B015', 770, TO_TIMESTAMP('2025-07-15 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'REF662107', 'COMPLETED');

INSERT INTO Payment  
VALUES ('P016', 'B016', 1832, TO_TIMESTAMP('2025-07-16 13:40:00', 'YYYY-MM-DD HH24:MI:SS'), 'REF391287', 'FAILED');

INSERT INTO Payment  
VALUES ('P017', 'B017', 440, TO_TIMESTAMP('2025-07-17 09:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'REF724509', 'COMPLETED');

INSERT INTO Payment  
VALUES ('P018', 'B018', 630, TO_TIMESTAMP('2025-07-18 14:55:00', 'YYYY-MM-DD HH24:MI:SS'), 'REF842116', 'PENDING');

INSERT INTO Payment  
VALUES ('P019', 'B019', 3305, TO_TIMESTAMP('2025-07-19 11:18:00', 'YYYY-MM-DD HH24:MI:SS'), 'REF290675', 'COMPLETED');

INSERT INTO Payment  
VALUES ('P020', 'B020', 8880, TO_TIMESTAMP('2025-07-20 15:40:00', 'YYYY-MM-DD HH24:MI:SS'), 'REF503712', 'COMPLETED');

INSERT INTO Payment  
VALUES ('P021', 'B021', 1832, TO_TIMESTAMP('2025-07-21 10:05:00', 'YYYY-MM-DD HH24:MI:SS'), 'REF617204', 'PENDING');

INSERT INTO Payment  
VALUES ('P022', 'B022', 9990, TO_TIMESTAMP('2025-07-22 14:35:00', 'YYYY-MM-DD HH24:MI:SS'), 'REF806391', 'COMPLETED');

INSERT INTO Payment  
VALUES ('P023', 'B023', 5525, TO_TIMESTAMP('2025-07-23 09:50:00', 'YYYY-MM-DD HH24:MI:SS'), 'REF438201', 'FAILED');

INSERT INTO Payment  
VALUES ('P024', 'B024', 1832, TO_TIMESTAMP('2025-07-24 13:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'REF920317', 'COMPLETED');

INSERT INTO Payment  
VALUES ('P025', 'B025', 4410, TO_TIMESTAMP('2025-07-25 11:10:00', 'YYYY-MM-DD HH24:MI:SS'), 'REF370916', 'PENDING');

INSERT INTO Payment  
VALUES ('P026', 'B026', 7700, TO_TIMESTAMP('2025-07-26 14:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'REF685102', 'COMPLETED');

INSERT INTO Payment  
VALUES ('P027', 'B027', 3315, TO_TIMESTAMP('2025-07-27 10:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'REF104763', 'FAILED');

INSERT INTO Payment  
VALUES ('P028', 'B028', 6645, TO_TIMESTAMP('2025-07-28 15:55:00', 'YYYY-MM-DD HH24:MI:SS'), 'REF837210', 'COMPLETED');

INSERT INTO Payment  
VALUES ('P029', 'B029', 1832, TO_TIMESTAMP('2025-07-29 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'REF219743', 'COMPLETED');

INSERT INTO Payment  
VALUES ('P030', 'B030', 3180, TO_TIMESTAMP('2025-07-30 11:35:00', 'YYYY-MM-DD HH24:MI:SS'), 'REF562801', 'PENDING');

--Insert payment record for Booking--

INSERT INTO Card_Payment VALUES ('P001', 'a83fd7b12e83cd271a71c55f8e843f', 'VISA', 'Alice Wang', '123 Pitt St, Sydney NSW 2000', 'AUD');
INSERT INTO Card_Payment VALUES ('P002', 'bd61e2ca590fa871c3ee157eaa4ce9', 'MASTERCARD', 'Brad Jones', '456 Mission Blvd, San Francisco CA 94103', 'USD');
INSERT INTO Card_Payment VALUES ('P003', 'c772b28e4ae3342f91d3c842f34b5a', 'AMEX', 'Cathy Li', '88 Zhongshan Rd, Shanghai', 'CNY');
INSERT INTO Card_Payment VALUES ('P004', 'f1ac8d95e2034dbcd292f0bdf244d3', 'VISA', 'Daniel Kim', '25 Gangnam Ave, Seoul', 'KRW');
INSERT INTO Card_Payment VALUES ('P005', '2e3b672d90aa877cf8cabc329b8f12', 'DISCOVER', 'Eva Davis', '78 Oxford St, London', 'GBP');
INSERT INTO Card_Payment VALUES ('P006', '99cd8fae6579db398c71ab3b2af324', 'MASTERCARD', 'Frank Lee', '12 Bloor St, Toronto', 'CAD');
INSERT INTO Card_Payment VALUES ('P007', 'a1f5cbd4f62d21a0f6f13ec3ab763e', 'VISA', 'Grace Kim', '2 Orchard Rd, Singapore', 'USD');
INSERT INTO Card_Payment VALUES ('P008', 'd4a39fc0caa2dfbe13f93f927a6439', 'AMEX', 'Hannah Nguyen', '56 Tran Hung Dao St, Ho Chi Minh City', 'USD');
INSERT INTO Card_Payment VALUES ('P009', '6d13c5f9b7aa351f41ae4cdffabfe2', 'VISA', 'Irene Lopez', 'Calle Mayor 12, Madrid', 'EUR');
INSERT INTO Card_Payment VALUES ('P010', 'bb739a65feee223dd179c183f9a3f8', 'MASTERCARD', 'Jack Hall', '789 Sunset Blvd, Los Angeles CA', 'USD');
INSERT INTO Card_Payment VALUES ('P011', '1fa92d43971edcbc5b780cecd54e7a', 'DISCOVER', 'Karen Patel', '45 MG Road, Mumbai', 'USD');
INSERT INTO Card_Payment VALUES ('P012', '87e52f4b6cb55cd13c15ed9883473e', 'AMEX', 'Leon Wong', '123 Nanjing Rd, Beijing', 'CNY');
INSERT INTO Card_Payment VALUES ('P013', '3ec1faba11c2544b56fa1d3a4e75fb', 'VISA', 'Mia Garcia', '9th Ave, Manhattan NY', 'USD');
INSERT INTO Card_Payment VALUES ('P014', 'cd3a123456bb20ff781d94f83e96d2', 'MASTERCARD', 'Nate Singh', '250 George St, Sydney NSW', 'AUD');
INSERT INTO Card_Payment VALUES ('P015', '72d6fb42991e0ca61be1827164b210', 'AMEX', 'Olivia Martinez', 'Rua Visconde, Rio de Janeiro', 'USD');

--Insert Crypto record for booking--

INSERT INTO Crypto_Payment VALUES ('P016', '0x3f8d4a7b1e6d7a91cf32e8bb7a6adf12e43', '0xEf129Bbca9F86de2d88Cc6134B77cF67', 'BTC',  'TXa91b7f8e3cd2d17d12348cd89a1');
INSERT INTO Crypto_Payment VALUES ('P017', '0x9c1f44b0a09c79a6f7e2c11523cfbd893d5', '0xCc229Dfef613b7614ea981223B5AdAB9', 'ETH',  'TX7fb68c3e994afc7e8ad314a');
INSERT INTO Crypto_Payment VALUES ('P018', '0x7e4a1cd99fa430be5e7242e14931d37aa0', '0xBEEf5D76c3Ab9279A8F75eAA9D129E77', 'USDT', 'TXcf1b82d334af209aa7e1d0ce');
INSERT INTO Crypto_Payment VALUES ('P019', '0x1a2b3c4d5e6f7890a1b2c3d4e5f6a7b8c9d', '0xDADAe9123eFaCC33457987EfBc123456', 'ETH',  'TX9023adb237acbd34f9810ed');
INSERT INTO Crypto_Payment VALUES ('P020', '0xabc123def456789abc123def456789abc12', '0x123DEFabc456789ABCdef123456789ab', 'USDC', 'TXf78ab1d27ed4c38b9ea23d8');
INSERT INTO Crypto_Payment VALUES ('P021', '0x88e1f94c35d12c00b612ef9811ad0012fbd', '0x0012fbd23cd456ef78c90adbc1e23456', 'BTC',  'TX9d4c65fb1a7e238bc5e17cd');
INSERT INTO Crypto_Payment VALUES ('P022', '0x5e33f1a82d48c7ab6f03ed2149cbf1deadc', '0xDeadBeefFaCe1234567890ABCDEf1234', 'ETH',  'TXcb87239dfe2349cc91ab8e2');
INSERT INTO Crypto_Payment VALUES ('P023', '0x33ab992e7745a19fe3d8baee943fe12cb67', '0xAAbbCCddEEff00112233445566778899', 'USDT', 'TX4d1a67bbcbdefe91ea0cc9a');
INSERT INTO Crypto_Payment VALUES ('P024', '0x10e5bfc41dce3f11b887b32f40cde2bc0a1', '0x321Bbcc1190aDEFa55BcCe890adfa76a', 'USDC', 'TX8fbd344c982adcba91dca43');
INSERT INTO Crypto_Payment VALUES ('P025', '0xCc1e2b3d4a5f6e7b8c9d01e234fbc9da891', '0x7788aabbccddeeff0011223344556677', 'BTC',  'TX312efcb47adbecc33cb8cce');
INSERT INTO Crypto_Payment VALUES ('P026', '0xABCDEF1234567890abcdef1234567890ab', '0xABC123456789DEFABC1234567890DEFA', 'ETH',  'TX1fbd7843c21decdaf1283a');
INSERT INTO Crypto_Payment VALUES ('P027', '0x00112233445566778899aabbccddeeffaa', '0xffeeddccbbaa99887766554433221100', 'USDC', 'TXe39ab234c87a92bc3812cd');
INSERT INTO Crypto_Payment VALUES ('P028', '0x11223344556677889900aabbccddeeffaa', '0xaabbccddeeff00112233445566778899', 'BTC',  'TXd9aeb134cad129cb84c112e');
INSERT INTO Crypto_Payment VALUES ('P029', '0xCAFE1234DEADBEEF5678CAFE1234BEEF56', '0xFEED56781234CAFE1234DEAD5678BEEF', 'ETH',  'TXb1c22e99acaf289dc311ce3');
INSERT INTO Crypto_Payment VALUES ('P030', '0xBEEF5678DEADBEEF1234567890ABCDEF12', '0xCAFEBABEDEAD1234567890DEADBABE12', 'USDT', 'TX7890cabdee90adc381ceecf');

-- Feedback from booking --

INSERT INTO Guest_Feedback
(Feedback_Id, Booking_Id, Overall_Rating, Venue_Rating, Staff_Rating, Sustainability_Score,
 Comments, Feedback_Date_Time, Would_Recommend, Suggestions)
VALUES
('F001', 'B001', 4, 3, 5, 4,
 'Weather was perfect for the event.', '2025-07-19 15:54:00', 'Y', 'Provide clearer signage');

INSERT INTO Guest_Feedback
(Feedback_Id, Booking_Id, Overall_Rating, Venue_Rating, Staff_Rating, Sustainability_Score,
 Comments, Feedback_Date_Time, Would_Recommend, Suggestions)
VALUES
('F002', 'B002', 5, 5, 4, 5,
 'Staff were friendly and helpful.', '2025-07-27 12:31:00', 'Y', 'Offer more vegetarian options');

INSERT INTO Guest_Feedback
(Feedback_Id, Booking_Id, Overall_Rating, Venue_Rating, Staff_Rating, Sustainability_Score,
 Comments, Feedback_Date_Time, Would_Recommend, Suggestions)
VALUES
('F003', 'B003', 5, 4, 4, 5,
 'Loved the sustainability efforts.', '2025-07-07 18:46:00', 'Y', 'Offer shuttle service');
 
INSERT INTO Guest_Feedback
(Feedback_Id, Booking_Id, Overall_Rating, Venue_Rating, Staff_Rating, Sustainability_Score,
 Comments, Feedback_Date_Time, Would_Recommend, Suggestions)
VALUES
('F004', 'B004', 4, 4, 4, 3,
 'Venue was clean and well organized.', '2025-07-02 14:25:00', 'Y', 'Enhance mobile app support');
 
INSERT INTO Guest_Feedback
(Feedback_Id, Booking_Id, Overall_Rating, Venue_Rating, Staff_Rating, Sustainability_Score,
 Comments, Feedback_Date_Time, Would_Recommend, Suggestions)
VALUES
('F005', 'B005', 3, 3, 4, 3,
 'Needs improvement on food service.', '2025-07-23 11:50:00', 'N', 'Better lighting needed');

INSERT INTO Guest_Feedback
(Feedback_Id, Booking_Id, Overall_Rating, Venue_Rating, Staff_Rating, Sustainability_Score,
 Comments, Feedback_Date_Time, Would_Recommend, Suggestions)
VALUES
('F006', 'B006', 4, 4, 5, 5,
 'Had a wonderful time, will return.', '2025-07-13 13:46:00', 'Y', 'Add charging stations');

INSERT INTO Guest_Feedback
(Feedback_Id, Booking_Id, Overall_Rating, Venue_Rating, Staff_Rating, Sustainability_Score,
 Comments, Feedback_Date_Time, Would_Recommend, Suggestions)
VALUES
('F007', 'B007', 5, 5, 5, 4,
 'Great ambiance and location.', '2025-07-29 12:39:00', 'Y', 'Include more tech showcases'); 
 
INSERT INTO Guest_Feedback
(Feedback_Id, Booking_Id, Overall_Rating, Venue_Rating, Staff_Rating, Sustainability_Score,
 Comments, Feedback_Date_Time, Would_Recommend, Suggestions)
VALUES
('F008', 'B008', 4, 3, 5, 4,
 'Check-in process was smooth.', '2025-07-17 18:24:00', 'Y', 'Improve seating comfort');
 
INSERT INTO Guest_Feedback
(Feedback_Id, Booking_Id, Overall_Rating, Venue_Rating, Staff_Rating, Sustainability_Score,
 Comments, Feedback_Date_Time, Would_Recommend, Suggestions)
VALUES
('F009', 'B009', 4, 4, 3, 5,
 'Amazing service and great staff!', '2025-07-30 14:18:00', 'Y', 'Extend the session duration');
 
INSERT INTO Guest_Feedback
(Feedback_Id, Booking_Id, Overall_Rating, Venue_Rating, Staff_Rating, Sustainability_Score,
 Comments, Feedback_Date_Time, Would_Recommend, Suggestions)
VALUES
('F010', 'B010', 3, 4, 4, 3,
 'Music was too loud.', '2025-07-26 19:12:00', 'N', 'Add live commentary');
 
INSERT INTO Guest_Feedback
(Feedback_Id, Booking_Id, Overall_Rating, Venue_Rating, Staff_Rating, Sustainability_Score,
 Comments, Feedback_Date_Time, Would_Recommend, Suggestions)
VALUES
('F011', 'B011', 5, 5, 5, 5,
 'Loved the sustainability efforts.', '2025-07-15 13:11:00', 'Y', 'Offer shuttle service');
 
INSERT INTO Guest_Feedback
(Feedback_Id, Booking_Id, Overall_Rating, Venue_Rating, Staff_Rating, Sustainability_Score,
 Comments, Feedback_Date_Time, Would_Recommend, Suggestions)
VALUES
('F012', 'B012', 4, 4, 3, 4,
 'Venue was clean and well organized.', '2025-07-03 10:06:00', 'Y', 'Add charging stations');
 
INSERT INTO Guest_Feedback
(Feedback_Id, Booking_Id, Overall_Rating, Venue_Rating, Staff_Rating, Sustainability_Score,
 Comments, Feedback_Date_Time, Would_Recommend, Suggestions)
VALUES
('F013', 'B013', 5, 5, 4, 5,
 'Had a wonderful time, will return.', '2025-07-11 15:34:00', 'Y', 'Extend the session duration');

INSERT INTO Guest_Feedback
(Feedback_Id, Booking_Id, Overall_Rating, Venue_Rating, Staff_Rating, Sustainability_Score,
 Comments, Feedback_Date_Time, Would_Recommend, Suggestions)
VALUES
('F014', 'B014', 3, 4, 3, 3,
 'Music was too loud.', '2025-07-12 16:50:00', 'N', 'Improve seating comfort');

INSERT INTO Guest_Feedback
(Feedback_Id, Booking_Id, Overall_Rating, Venue_Rating, Staff_Rating, Sustainability_Score,
 Comments, Feedback_Date_Time, Would_Recommend, Suggestions)
VALUES
('F015', 'B015', 4, 5, 5, 4,
 'Check-in process was smooth.', '2025-07-10 11:14:00', 'Y', 'Enhance mobile app support');

INSERT INTO Guest_Feedback
(Feedback_Id, Booking_Id, Overall_Rating, Venue_Rating, Staff_Rating, Sustainability_Score,
 Comments, Feedback_Date_Time, Would_Recommend, Suggestions)
VALUES
('F016', 'B016', 3, 3, 4, 3,
 'Needs improvement on food service.', '2025-07-01 10:53:00', 'N', 'Better lighting needed');

INSERT INTO Guest_Feedback
(Feedback_Id, Booking_Id, Overall_Rating, Venue_Rating, Staff_Rating, Sustainability_Score,
 Comments, Feedback_Date_Time, Would_Recommend, Suggestions)
VALUES
('F017', 'B017', 5, 4, 5, 5,
 'Staff were friendly and helpful.', '2025-07-16 12:31:00', 'Y', 'Offer more vegetarian options');

INSERT INTO Guest_Feedback
(Feedback_Id, Booking_Id, Overall_Rating, Venue_Rating, Staff_Rating, Sustainability_Score,
 Comments, Feedback_Date_Time, Would_Recommend, Suggestions)
VALUES
('F018', 'B018', 4, 4, 4, 4,
 'Great ambiance and location.', '2025-07-05 11:41:00', 'Y', 'Include more tech showcases');

INSERT INTO Guest_Feedback
(Feedback_Id, Booking_Id, Overall_Rating, Venue_Rating, Staff_Rating, Sustainability_Score,
 Comments, Feedback_Date_Time, Would_Recommend, Suggestions)
VALUES
('F019', 'B019', 5, 5, 5, 5,
 'Amazing service and great staff!', '2025-07-20 14:29:00', 'Y', 'Add charging stations');

INSERT INTO Guest_Feedback
(Feedback_Id, Booking_Id, Overall_Rating, Venue_Rating, Staff_Rating, Sustainability_Score,
 Comments, Feedback_Date_Time, Would_Recommend, Suggestions)
VALUES
('F020', 'B020', 4, 4, 4, 5,
 'Weather was perfect for the event.', '2025-07-09 13:22:00', 'Y', 'Extend the session duration');

INSERT INTO Guest_Feedback
(Feedback_Id, Booking_Id, Overall_Rating, Venue_Rating, Staff_Rating, Sustainability_Score,
 Comments, Feedback_Date_Time, Would_Recommend, Suggestions)
VALUES
('F021', 'B021', 3, 3, 4, 3,
 'Music was too loud.', '2025-07-18 12:06:00', 'N', 'Improve seating comfort');

INSERT INTO Guest_Feedback
(Feedback_Id, Booking_Id, Overall_Rating, Venue_Rating, Staff_Rating, Sustainability_Score,
 Comments, Feedback_Date_Time, Would_Recommend, Suggestions)
VALUES
('F022', 'B022', 5, 5, 5, 4,
 'Check-in process was smooth.', '2025-07-14 16:43:00', 'Y', 'Provide clearer signage');

INSERT INTO Guest_Feedback
(Feedback_Id, Booking_Id, Overall_Rating, Venue_Rating, Staff_Rating, Sustainability_Score,
 Comments, Feedback_Date_Time, Would_Recommend, Suggestions)
VALUES
('F023', 'B023', 4, 4, 3, 4,
 'Venue was clean and well organized.', '2025-07-22 11:20:00', 'Y', 'Add live commentary');

INSERT INTO Guest_Feedback
(Feedback_Id, Booking_Id, Overall_Rating, Venue_Rating, Staff_Rating, Sustainability_Score,
 Comments, Feedback_Date_Time, Would_Recommend, Suggestions)
VALUES
('F024', 'B024', 5, 5, 4, 5,
 'Had a wonderful time, will return.', '2025-07-04 13:40:00', 'Y', 'Offer shuttle service');

INSERT INTO Guest_Feedback
(Feedback_Id, Booking_Id, Overall_Rating, Venue_Rating, Staff_Rating, Sustainability_Score,
 Comments, Feedback_Date_Time, Would_Recommend, Suggestions)
VALUES
('F025', 'B025', 4, 3, 5, 4,
 'Loved the sustainability efforts.', '2025-07-25 10:17:00', 'Y', 'Enhance mobile app support');

INSERT INTO Guest_Feedback
(Feedback_Id, Booking_Id, Overall_Rating, Venue_Rating, Staff_Rating, Sustainability_Score,
 Comments, Feedback_Date_Time, Would_Recommend, Suggestions)
VALUES
('F026', 'B026', 5, 5, 5, 5,
 'Staff were friendly and helpful.', '2025-07-08 17:08:00', 'Y', 'Extend the session duration');

INSERT INTO Guest_Feedback
(Feedback_Id, Booking_Id, Overall_Rating, Venue_Rating, Staff_Rating, Sustainability_Score,
 Comments, Feedback_Date_Time, Would_Recommend, Suggestions)
VALUES
('F027', 'B027', 3, 3, 4, 3,
 'Needs improvement on food service.', '2025-07-21 15:33:00', 'N', 'Improve seating comfort');

INSERT INTO Guest_Feedback
(Feedback_Id, Booking_Id, Overall_Rating, Venue_Rating, Staff_Rating, Sustainability_Score,
 Comments, Feedback_Date_Time, Would_Recommend, Suggestions)
VALUES
('F028', 'B028', 4, 4, 5, 4,
 'Great ambiance and location.', '2025-07-06 14:57:00', 'Y', 'Add charging stations');

INSERT INTO Guest_Feedback
(Feedback_Id, Booking_Id, Overall_Rating, Venue_Rating, Staff_Rating, Sustainability_Score,
 Comments, Feedback_Date_Time, Would_Recommend, Suggestions)
VALUES
('F029', 'B029', 5, 5, 5, 5,
 'Amazing service and great staff!', '2025-07-28 11:03:00', 'Y', 'Offer more vegetarian options');

INSERT INTO Guest_Feedback
(Feedback_Id, Booking_Id, Overall_Rating, Venue_Rating, Staff_Rating, Sustainability_Score,
 Comments, Feedback_Date_Time, Would_Recommend, Suggestions)
VALUES
('F030', 'B030', 4, 4, 4, 4,
 'Weather was perfect for the event.', '2025-07-24 12:12:00', 'Y', 'Provide clearer signage');

--Staff Assignments for Bookings--

INSERT INTO Staff_Assignment (Staff_Id, Booking_Id, Role, Start_Time, End_Time, Status, Special_Instructions, Created_Date)
VALUES ('HS001', 'B001', 'HOST', TO_TIMESTAMP('2025-08-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-08-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'CANCELLED', 'Duty for booking B001', TO_DATE('2025-08-01', 'YYYY-MM-DD'));

INSERT INTO Staff_Assignment 
VALUES ('HS002', 'B002', 'CLEANER', TO_TIMESTAMP('2025-08-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-08-01 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'IN_PROGRESS', 'Duty for booking B002', TO_DATE('2025-08-01', 'YYYY-MM-DD'));

INSERT INTO Staff_Assignment 
VALUES ('HS003', 'B003', 'BARTENDER', TO_TIMESTAMP('2025-08-01 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-08-01 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'IN_PROGRESS', 'Duty for booking B003', TO_DATE('2025-08-01', 'YYYY-MM-DD'));

INSERT INTO Staff_Assignment 
VALUES ('HS004', 'B004', 'OTHER', TO_TIMESTAMP('2025-08-01 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-08-01 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'COMPLETED', 'Duty for booking B004', TO_DATE('2025-08-01', 'YYYY-MM-DD'));

INSERT INTO Staff_Assignment 
VALUES ('HS005', 'B005', 'HOST', TO_TIMESTAMP('2025-08-01 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-08-01 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'ASSIGNED', 'Duty for booking B005', TO_DATE('2025-08-01', 'YYYY-MM-DD'));

INSERT INTO Staff_Assignment
VALUES ('HS006', 'B006', 'CLEANER', TO_TIMESTAMP('2025-08-01 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-08-01 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'COMPLETED', 'Duty for booking B006', TO_DATE('2025-08-01', 'YYYY-MM-DD'));

INSERT INTO Staff_Assignment
VALUES ('HS007', 'B007', 'WAITER', TO_TIMESTAMP('2025-08-01 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-08-01 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'ASSIGNED', 'Duty for booking B007', TO_DATE('2025-08-01', 'YYYY-MM-DD'));

INSERT INTO Staff_Assignment
VALUES ('HS008', 'B008', 'HOST', TO_TIMESTAMP('2025-08-01 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-08-01 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'COMPLETED', 'Duty for booking B008', TO_DATE('2025-08-01', 'YYYY-MM-DD'));

INSERT INTO Staff_Assignment
VALUES ('HS009', 'B009', 'BARTENDER', TO_TIMESTAMP('2025-08-01 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-08-01 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'ASSIGNED', 'Duty for booking B009', TO_DATE('2025-08-01', 'YYYY-MM-DD'));

INSERT INTO Staff_Assignment
VALUES ('HS010', 'B010', 'SECURITY', TO_TIMESTAMP('2025-08-01 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-08-01 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'CANCELLED', 'Duty for booking B010', TO_DATE('2025-08-01', 'YYYY-MM-DD'));

INSERT INTO Staff_Assignment
VALUES ('HS011', 'B011', 'HOST', TO_TIMESTAMP('2025-08-01 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-08-01 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'IN_PROGRESS', 'Duty for booking B011', TO_DATE('2025-08-01', 'YYYY-MM-DD'));

INSERT INTO Staff_Assignment
VALUES ('HS012', 'B012', 'OTHER', TO_TIMESTAMP('2025-08-01 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-08-01 21:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'ASSIGNED', 'Duty for booking B012', TO_DATE('2025-08-01', 'YYYY-MM-DD'));

INSERT INTO Staff_Assignment
VALUES ('HS013', 'B013', 'CLEANER', TO_TIMESTAMP('2025-08-01 21:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-08-01 22:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'IN_PROGRESS', 'Duty for booking B013', TO_DATE('2025-08-01', 'YYYY-MM-DD'));

INSERT INTO Staff_Assignment
VALUES ('HS014', 'B014', 'SECURITY', TO_TIMESTAMP('2025-08-01 22:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-08-01 23:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'COMPLETED', 'Duty for booking B014', TO_DATE('2025-08-01', 'YYYY-MM-DD'));

INSERT INTO Staff_Assignment
VALUES ('HS015', 'B015', 'WAITER', TO_TIMESTAMP('2025-08-01 23:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-08-02 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'CANCELLED', 'Duty for booking B015', TO_DATE('2025-08-01', 'YYYY-MM-DD'));

INSERT INTO Staff_Assignment
VALUES ('HS016', 'B016', 'BARTENDER', TO_TIMESTAMP('2025-08-02 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-08-02 01:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'COMPLETED', 'Duty for booking B016', TO_DATE('2025-08-02', 'YYYY-MM-DD'));

INSERT INTO Staff_Assignment
VALUES ('HS017', 'B017', 'OTHER', TO_TIMESTAMP('2025-08-02 01:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-08-02 02:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'ASSIGNED', 'Duty for booking B017', TO_DATE('2025-08-02', 'YYYY-MM-DD'));

INSERT INTO Staff_Assignment
VALUES ('HS018', 'B018', 'HOST', TO_TIMESTAMP('2025-08-02 02:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-08-02 03:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'CANCELLED', 'Duty for booking B018', TO_DATE('2025-08-02', 'YYYY-MM-DD'));

INSERT INTO Staff_Assignment
VALUES ('HS019', 'B019', 'SECURITY', TO_TIMESTAMP('2025-08-02 03:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-08-02 04:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'COMPLETED', 'Duty for booking B019', TO_DATE('2025-08-02', 'YYYY-MM-DD'));

INSERT INTO Staff_Assignment
VALUES ('HS020', 'B020', 'WAITER', TO_TIMESTAMP('2025-08-02 04:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-08-02 05:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'IN_PROGRESS', 'Duty for booking B020', TO_DATE('2025-08-02', 'YYYY-MM-DD'));

INSERT INTO Staff_Assignment
VALUES ('HS021', 'B021', 'CLEANER', TO_TIMESTAMP('2025-08-02 05:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-08-02 06:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'ASSIGNED', 'Duty for booking B021', TO_DATE('2025-08-02', 'YYYY-MM-DD'));

INSERT INTO Staff_Assignment
VALUES ('HS022', 'B022', 'HOST', TO_TIMESTAMP('2025-08-02 06:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-08-02 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'IN_PROGRESS', 'Duty for booking B022', TO_DATE('2025-08-02', 'YYYY-MM-DD'));

INSERT INTO Staff_Assignment
VALUES ('HS023', 'B023', 'OTHER', TO_TIMESTAMP('2025-08-02 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-08-02 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'COMPLETED', 'Duty for booking B023', TO_DATE('2025-08-02', 'YYYY-MM-DD'));

INSERT INTO Staff_Assignment
VALUES ('HS024', 'B024', 'SECURITY', TO_TIMESTAMP('2025-08-02 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-08-02 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'CANCELLED', 'Duty for booking B024', TO_DATE('2025-08-02', 'YYYY-MM-DD'));

INSERT INTO Staff_Assignment
VALUES ('HS025', 'B025', 'BARTENDER', TO_TIMESTAMP('2025-08-02 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-08-02 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'COMPLETED', 'Duty for booking B025', TO_DATE('2025-08-02', 'YYYY-MM-DD'));

INSERT INTO Staff_Assignment
VALUES ('HS026', 'B026', 'WAITER', TO_TIMESTAMP('2025-08-02 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-08-02 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'IN_PROGRESS', 'Duty for booking B026', TO_DATE('2025-08-02', 'YYYY-MM-DD'));

INSERT INTO Staff_Assignment
VALUES ('HS027', 'B027', 'HOST', TO_TIMESTAMP('2025-08-02 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-08-02 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'ASSIGNED', 'Duty for booking B027', TO_DATE('2025-08-02', 'YYYY-MM-DD'));

INSERT INTO Staff_Assignment
VALUES ('HS028', 'B028', 'OTHER', TO_TIMESTAMP('2025-08-02 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-08-02 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'COMPLETED', 'Duty for booking B028', TO_DATE('2025-08-02', 'YYYY-MM-DD'));

INSERT INTO Staff_Assignment
VALUES ('HS029', 'B029', 'SECURITY', TO_TIMESTAMP('2025-08-02 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-08-02 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'IN_PROGRESS', 'Duty for booking B029', TO_DATE('2025-08-02', 'YYYY-MM-DD'));

INSERT INTO Staff_Assignment
VALUES ('HS030', 'B030', 'CLEANER', TO_TIMESTAMP('2025-08-02 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-08-02 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'CANCELLED', 'Duty for booking B030', TO_DATE('2025-08-02', 'YYYY-MM-DD'));

































