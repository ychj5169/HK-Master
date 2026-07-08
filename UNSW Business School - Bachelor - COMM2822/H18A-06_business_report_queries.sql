SELECT Membership_Rank, ROUND(AVG(Carbon_Credits), 2) AS Avg_Credits
FROM Vip_Guest
GROUP BY Membership_Rank;

SELECT Venue_Type, COUNT(*) AS Venue_Count
FROM Experience_Venue
GROUP BY Venue_Type
HAVING SUM(Capacity) > 100;

SELECT Guest_Id, First_Name, Last_Name, Carbon_Credits
FROM Vip_Guest
WHERE Carbon_Credits > (
    SELECT AVG(Carbon_Credits)
    FROM Vip_Guest
);

SELECT ig.Nationality, COUNT(bg.Booking_Id) AS Total_Bookings
FROM Booking_Guest bg
JOIN Vip_Guest vg ON bg.Guest_Id = vg.Guest_Id
JOIN Individual_Guest ig ON vg.Guest_Id = ig.Guest_Id
GROUP BY ig.Nationality
ORDER BY Total_Bookings DESC;


SELECT b.Booking_Id,
       vg.Guest_Id,
       CASE
         WHEN ig.Guest_Id IS NOT NULL THEN 'Individual'
         WHEN cg.Guest_Id IS NOT NULL THEN 'Corporate'
         ELSE 'Unknown'
       END AS Guest_Type
FROM Booking b
RIGHT JOIN Booking_Guest bg ON b.Booking_Id = bg.Booking_Id
LEFT JOIN Vip_Guest vg ON bg.Guest_Id = vg.Guest_Id
LEFT JOIN Individual_Guest ig ON vg.Guest_Id = ig.Guest_Id
LEFT JOIN Corporate_Guest cg ON vg.Guest_Id = cg.Guest_Id;

SELECT Location, COUNT(*) AS Available_With_Bar
FROM Experience_Venue
WHERE Status = 'AVAILABLE' AND Has_Bar_Service = 'Y'
GROUP BY Location
HAVING COUNT(*) >= 1;

SELECT vg.Membership_Rank, COUNT(bg.Booking_Id) AS Booking_Count
FROM Vip_Guest vg
JOIN Booking_Guest bg ON vg.Guest_Id = bg.Guest_Id
GROUP BY vg.Membership_Rank
HAVING vg.Membership_Rank = (
  SELECT MAX(Membership_Rank)
  FROM Vip_Guest
)
ORDER BY Booking_Count ASC;
