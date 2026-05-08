-- Database Schema for Event Management System
-- DDL (Data Definition Language) Queries

-- Drop tables if they exist (in reverse order of dependencies)
/*DROP TABLE IF EXISTS Payments;
DROP TABLE IF EXISTS Event_Services;
DROP TABLE IF EXISTS Bookings;
DROP TABLE IF EXISTS Services;
DROP TABLE IF EXISTS _Events;
DROP TABLE IF EXISTS Organizers;*/
                                                 -- DROP TABLE Payments,Event_Services,Services,Bookings,Events,Organizers;
-- Create Organizers table
CREATE TABLE Organizers (
    organizer_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20) UNIQUE,
    address VARCHAR(150)
);

-- Create Events table (renamed from _Events to avoid special character)
CREATE TABLE Events (
    event_id INT PRIMARY KEY,
    name VARCHAR(100) UNIQUE,
    event_type VARCHAR(100),
    date DATE,
    time TIME,
    location VARCHAR(100),
    organizer_id INT,
    FOREIGN KEY (organizer_id) REFERENCES Organizers(organizer_id)
);

-- Create Services table
CREATE TABLE Services (
    service_id INT PRIMARY KEY,
    service_name VARCHAR(100) UNIQUE,
    description TEXT,
    cost DECIMAL(10, 2) CHECK (cost >= 0)
);

-- Create Bookings table
CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY,
    event_id INT,
    payment_status VARCHAR(20),
    payment_method VARCHAR(50),
    amount DECIMAL(10, 2),
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
);

-- Create Event_Services junction table
CREATE TABLE Event_Services (
    event_id INT,
    service_id INT,
    quantity INT NOT NULL CHECK (quantity > 0),
    PRIMARY KEY (event_id, service_id),
    FOREIGN KEY (event_id) REFERENCES Events(event_id),
    FOREIGN KEY (service_id) REFERENCES Services(service_id)
);

-- Create Payments table
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    booking_id INT,
    payment_date DATE,
    amount_paid DECIMAL(10, 2),
    payment_status VARCHAR(20),
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
);

-- Alter tables to modify structure as needed
ALTER TABLE Organizers MODIFY phone VARCHAR(20);
ALTER TABLE Events MODIFY event_type VARCHAR(100);
ALTER TABLE Organizers DROP COLUMN address ;
ALTER TABLE Organizers ADD COLUMN address VARCHAR(150);

-- DML (Data Manipulation Language) Queries
-- Insert data into Organizers table
INSERT INTO Organizers VALUES 
(1001, 'Tabish Hashmi', 'tabishhashmj217@gmail.com', '03185240487', 'House No.677 Phase 8'),
(1002, 'Syed Tabish Hashmi', 'tabishhashmj317@gmail.com', '03185240480', '27 Street G8'),
(1003, 'Ayesha Siddiqui', 'ayesha.siddiqui@gmail.com', '03214567890', 'DHA Phase 5, Karachi'),
(1004, 'Ali Raza', 'aliraza.official@gmail.com', '03001234567', 'Gulberg, Lahore'),
(1005, 'Zainab Khan', 'zainabkhan786@gmail.com', '03456789123', 'F-7, Islamabad'),
(1006, 'Ahmed Saeed', 'ahmed.saeed01@gmail.com', '03123456789', 'Clifton, Karachi'),
(1007, 'Hassan Tariq', 'hassan.tariq@gmail.com', '03019876543', 'Model Town, Lahore'),
(1008, 'Nimra Ali', 'nimra.ali@gmail.com', '03112345678', 'Bahria Town, Rawalpindi'),
(1009, 'Tariq Jamil', 'tariq.jamil@eventpro.pk', '03451234567', 'Gulshan-e-Iqbal, Karachi'),
(1010, 'Sarah Munir', 'sarah.munir@email.com', '03334567891', 'Sector H-9, Islamabad'),
(1011, 'Usman Ghani', 'usman.ghani@eventhub.pk', '03014567892', 'Johar Town, Lahore'),
(1012, 'Iqra Aslam', 'iqra.aslam@gmail.com', '03211234567', 'North Nazimabad, Karachi'),
(1013, 'Farhan Ali', 'farhan.ali@events.com', '03009871234', 'Satellite Town, Rawalpindi'),
(1014, 'Hiba Khan', 'hiba.khan@gmail.com', '03118765432', 'Faisal Town, Lahore'),
(1015, 'Junaid Jamshed', 'junaid.jamshed@eventhub.com', '03451238976', 'Cantt, Multan'),
(1016, 'Laiba Noor', 'laiba.noor@yahoo.com', '03021239876', 'Sector G-9, Islamabad'),
(1017, 'Kashif Mehmood', 'kashif.mehmood@gmail.com', '03122334455', 'I.I. Chundrigar Road, Karachi'),
(1018, 'Mehwish Tariq', 'mehwish.tariq@eventpro.pk', '03214567980', 'Askari 10, Lahore'),
(1019, 'Danish Ahmed', 'danish.ahmed@live.com', '03003456789', 'Bahria Town, Islamabad'),
(1020, 'Hira Yousaf', 'hira.yousaf@outlook.com', '03331234567', 'Gulistan-e-Jauhar, Karachi'),
(1021, 'Talha Anwar', 'talha.anwar@event.com', '03456712345', 'Saddar, Hyderabad');

-- Insert data into Events table
INSERT INTO Events VALUES 
(240, 'Huzaifas Walima', 'Wedding', '2025-04-12', '18:00', 'Golra E-11, Islamabad', 1001),
(241, 'Huzaifa Walima', 'Wedding', '2025-04-12', '18:00', 'Golra E-11, Islamabad', 1002),
(242, 'Areebas Mehndi', 'Wedding', '2025-05-01', '19:00', 'DHA Phase 6, Lahore', 1003),
(243, 'Osamas Birthday', 'Birthday', '2025-05-10', '17:00', 'Clifton, Karachi', 1004),
(244, 'Fatimas Nikah', 'Wedding', '2025-05-15', '18:30', 'Satellite Town, Rawalpindi', 1005),
(245, 'Bilals Graduation Party', 'Party', '2025-05-20', '20:00', 'Model Town, Lahore', 1006),
(246, 'Sanas Bridal Shower', 'Wedding', '2025-05-22', '16:00', 'F-10 Markaz, Islamabad', 1007),
(247, 'Hamzas Aqeeqah', 'Religious', '2025-06-01', '13:00', 'Gulshan-e-Iqbal, Karachi', 1008),
(248, 'Maryams Engagement', 'Wedding', '2025-06-03', '18:00', 'Johar Town, Lahore', 1009),
(249, 'Yasirs Corporate Meetup', 'Conference', '2025-06-10', '10:00', 'Blue Area, Islamabad', 1010),
(250, 'Aimans Baby Shower', 'Celebration', '2025-06-14', '15:00', 'North Nazimabad, Karachi', 1011),
(251, 'Iqras Bridal Shower', 'Wedding', '2025-06-20', '17:00', 'Gulshan-e-Maymar, Karachi', 1012),
(252, 'Farhans Walima', 'Wedding', '2025-06-22', '18:30', 'Westridge, Rawalpindi', 1013),
(253, 'Hibas Graduation', 'Party', '2025-06-25', '19:00', 'Faisal Town, Lahore', 1014),
(254, 'Junaids Nikah', 'Wedding', '2025-07-01', '20:00', 'Cantt, Multan', 1015),
(255, 'Laibas Baby Shower', 'Celebration', '2025-07-03', '16:00', 'Sector G-9, Islamabad', 1016),
(256, 'Kashifs Conference', 'Conference', '2025-07-06', '11:00', 'I.I. Chundrigar Road, Karachi', 1017),
(257, 'Mehwishs Engagement', 'Wedding', '2025-07-10', '18:00', 'Askari 10, Lahore', 1018),
(258, 'Danishs Seminar', 'Conference', '2025-07-12', '09:00', 'Bahria Town, Islamabad', 1019),
(259, 'Hiras Farewell', 'Party', '2025-07-14', '19:00', 'Gulistan-e-Jauhar, Karachi', 1020),
(260, 'Talhas Workshop', 'Conference', '2025-07-18', '14:00', 'Saddar, Hyderabad', 1021);

-- Insert data into Services table
INSERT INTO Services VALUES 
(1, 'Standard Catering', 'Buffet for 100 guests', 2500.00),
(2, 'Premium Catering', 'Gourmet buffet for 100 guests', 5000.00),
(3, 'Photography', 'HD Photography Package', 5000.00),
(4, 'Decoration', 'Stage and Hall Decoration', 10000.00),
(5, 'DJ Service', 'Music DJ with Sound System', 8000.00),
(6, 'Lighting', 'Full Venue Lighting', 6000.00),
(7, 'Security', '2 Security Guards', 4000.00),
(8, 'Valet Parking', 'Valet service for 50 cars', 3000.00),
(9, 'Event Planning', 'Full event coordination', 12000.00),
(10, 'Sound System', 'Speakers & microphones setup', 3500.00),
(11, 'Live Music', 'Live performance band', 11000.00),
(12, 'Video Coverage', 'Full HD Video Package', 6000.00),
(13, 'Makeup Service', 'Bridal Makeup Service', 9000.00),
(14, 'Stage Setup', 'Decorated stage setup', 7000.00),
(15, 'Florist', 'Fresh flowers decoration', 6500.00),
(16, 'MC Hosting', 'Event host / announcer', 4500.00),
(17, 'Traditional Dhol', 'Live dhol players', 4000.00),
(18, 'Invitation Printing', 'Custom invitation cards', 3500.00),
(19, 'Waiter Staff', 'Serving staff for events', 4800.00),
(20, 'Kids Entertainment', 'Clowns, games & fun zone', 5000.00),
(21, 'Car Rental', 'Luxury car for bride/groom', 8000.00);

-- Insert data into Bookings table
INSERT INTO Bookings VALUES 
(1, 240, 'Paid', 'Credit Card', 250000.00),
(2, 241, 'Paid', 'Cash', 250000.00),
(3, 242, 'Paid', 'Cash', 200000.00),
(4, 243, 'Pending', 'JazzCash', 50000.00),
(5, 244, 'Paid', 'Credit Card', 150000.00),
(6, 245, 'Paid', 'Bank Transfer', 80000.00),
(7, 246, 'Pending', 'EasyPaisa', 60000.00),
(8, 247, 'Paid', 'Cash', 90000.00),
(9, 248, 'Paid', 'Credit Card', 170000.00),
(10, 249, 'Pending', 'Bank Transfer', 300000.00),
(11, 250, 'Paid', 'JazzCash', 75000.00),
(12, 251, 'Paid', 'Bank Transfer', 160000.00),
(13, 252, 'Pending', 'Cash', 220000.00),
(14, 253, 'Paid', 'EasyPaisa', 130000.00),
(15, 254, 'Paid', 'JazzCash', 210000.00),
(16, 255, 'Pending', 'Credit Card', 195000.00),
(17, 256, 'Paid', 'Bank Transfer', 185000.00),
(18, 257, 'Paid', 'Cash', 145000.00),
(19, 258, 'Pending', 'JazzCash', 170000.00),
(20, 259, 'Paid', 'EasyPaisa', 155000.00),
(21, 260, 'Paid', 'Credit Card', 200000.00);

-- Insert data into Event_Services table
INSERT INTO Event_Services VALUES 
(240, 1, 1),
(241, 2, 1),
(242, 3, 1),
(243, 4, 1),
(244, 5, 1),
(245, 6, 1),
(246, 7, 2),
(247, 8, 1),
(248, 9, 1),
(249, 10, 1),
(250, 11, 1),
(251, 12, 1),
(252, 13, 1),
(253, 14, 1),
(254, 15, 1),
(255, 16, 1),
(256, 17, 2),
(257, 18, 1),
(258, 19, 2),
(259, 20, 1),
(260, 21, 1);

-- Insert data into Payments table
INSERT INTO Payments VALUES 
(1, 1, '2025-04-10', 250000.00, 'Paid'),
(2, 2, '2025-04-28', 200000.00, 'Paid'),
(3, 3, '2025-05-05', 50000.00, 'Pending'),
(4, 4, '2025-05-10', 150000.00, 'Paid'),
(5, 5, '2025-05-15', 80000.00, 'Paid'),
(6, 6, '2025-05-17', 60000.00, 'Pending'),
(7, 7, '2025-05-20', 90000.00, 'Paid'),
(8, 8, '2025-05-23', 170000.00, 'Paid'),
(9, 9, '2025-05-27', 300000.00, 'Pending'),
(10, 10, '2025-05-30', 75000.00, 'Paid'),
(11, 11, '2025-06-02', 160000.00, 'Paid'),
(12, 12, '2025-06-05', 220000.00, 'Pending'),
(13, 13, '2025-06-07', 130000.00, 'Paid'),
(14, 14, '2025-06-10', 210000.00, 'Paid'),
(15, 15, '2025-06-12', 195000.00, 'Pending'),
(16, 16, '2025-06-15', 185000.00, 'Paid'),
(17, 17, '2025-06-18', 145000.00, 'Paid'),
(18, 18, '2025-06-20', 170000.00, 'Pending'),
(19, 19, '2025-06-22', 155000.00, 'Paid'),
(20, 20, '2025-06-25', 200000.00, 'Paid');

-- Data Query Examples

-- 1. Show events with a booking amount greater than 150000
SELECT booking_id, event_id, amount
FROM Bookings
WHERE amount > 150000;

-- 2. Show services that cost between 1000 and 10000
SELECT service_id, service_name, cost
FROM Services
WHERE cost BETWEEN 1000 AND 10000;

-- 3. Show events of specific types
SELECT event_id, name, event_type
FROM Events
WHERE event_type IN ('Wedding', 'Conference');

-- 4. Find organizers whose names start with "A"
SELECT organizer_id, name, email
FROM Organizers
WHERE name LIKE 'A%';

-- 5. Find bookings that are either paid more than 100000 or still pending
SELECT booking_id, amount, payment_status
FROM Bookings
WHERE amount > 100000 OR payment_status = 'Pending';

-- 6. List payments sorted by date and then by amount descending
SELECT payment_id, booking_id, payment_date, amount_paid
FROM Payments
ORDER BY payment_date ASC, amount_paid DESC;

-- 7. List services by cost (most expensive first)
SELECT service_id, service_name, cost
FROM Services
ORDER BY cost DESC;

-- 8. List payments by amount (smallest first)
SELECT payment_id, booking_id, amount_paid, payment_status
FROM Payments
ORDER BY amount_paid ASC;

-- 9. Show event details with organizer information
SELECT e.event_id, e.name AS event_name, e.date, o.name AS organizer_name, o.phone
FROM Events e
JOIN Organizers o ON e.organizer_id = o.organizer_id;

-- 10. Show total revenue by event type
SELECT e.event_type, SUM(b.amount) AS total_revenue
FROM Events e
JOIN Bookings b ON e.event_id = b.event_id
GROUP BY e.event_type
ORDER BY total_revenue DESC;

-- 11. Show events with their services
SELECT e.event_id, e.name AS event_name, s.service_name, es.quantity, s.cost, (es.quantity * s.cost) AS total_cost
FROM Events e
JOIN Event_Services es ON e.event_id = es.event_id
JOIN Services s ON es.service_id = s.service_id
ORDER BY e.event_id;

-- 12. Show payment status summary
SELECT payment_status, COUNT(*) AS count, SUM(amount_paid) AS total_amount
FROM Payments
GROUP BY payment_status;

UPDATE Events 
SET organizer_id = 1010 
WHERE event_id = 240;

-- Describe table structures
DESCRIBE Organizers;
DESCRIBE Events;
DESCRIBE Bookings;
DESCRIBE Services;
DESCRIBE Event_Services;
DESCRIBE Payments;