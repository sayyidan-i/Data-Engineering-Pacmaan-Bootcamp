SELECT 
   table_name, 
   column_name, 
   data_type,
   is_nullable 
FROM 
   information_schema.columns
WHERE 
   table_name = 'room' or 
   table_name = 'room_type' or
   table_name = 'amenity' or
   table_name = 'customer' or
   table_name = 'reservation' or
   table_name = 'reservation_room' or
   table_name = 'payment'
ORDER BY table_name;



INSERT INTO room_type(name_type, max_occupacy, price, description)
VALUES('Premier', 2, 720000, 'Premier Rooms include the amenities you will need for a comfortable stay, such as an LED TV with international and local channels, comfortable beds and pillows with 100% cotton bed sheets and duvet, individual room AC, and a soothing rain shower. Coffee & tea making facilities are provided, No charge to Minibar Service, Super fast WiFi internet access is available throughout the hotel for you to enjoy.'),
('Deluxe', 2, 987000, 'Deluxe Premier Room offering a city view has a larger living area fitted with a seating area and writing desk. The rooms are convenient for any discerning  traveller who desires sufficient space for doing business.'),
('Executive', 2, 1450000, 'Spacious room suite features a foyer leading to a sitting area furnished with a sofa, coffee table, and writing desk. From the windows, the guests has an option to enjoy view of calm city streets or relaxing swimming pool. The bathroom is completed with a walk-in closet and bathtub. The guests stay include complimentary high speed Wi-Fi');

SELECT * FROM room_type;

INSERT INTO room(room_id, room_type_id, room_floor, availability)
VALUES(101, 1, 2, TRUE),
(102, 1, 2, TRUE),
(103, 1, 2, TRUE),
(104, 1, 2, FALSE),
(105, 1, 2, TRUE),
(106, 1, 2, TRUE),
(107, 1, 2, TRUE),
(108, 1, 2, TRUE),
(109, 1, 2, TRUE),
(110, 1, 2, TRUE),
(201, 1, 3, TRUE),
(202, 1, 3, FALSE),
(203, 1, 3, TRUE),
(204, 1, 3, TRUE),
(205, 1, 3, TRUE),
(206, 2, 3, TRUE),
(207, 2, 3, TRUE),
(208, 2, 3, TRUE),
(209, 2, 3, FALSE),
(210, 2, 3, TRUE);

SELECT * FROM room;

INSERT INTO customer(first_name, last_name, email, phone)
VALUES('Budi', 'Gunawan', 'budi123@mail.com', '0812345678'),
('Amalia', 'Ayu Hidayah', 'amel.hidayah@mail.com', NULL),
('Ayu', 'Ningtias Putri', 'ayuputri@mail.com', '0822345678'),
('Muhammad Abdi', 'Najat', 'abdi98@yaho.com', '0819999678'),
('Rayhan', 'Malik Prakasa', 'malik234@mail.com', NULL),
('Shania', 'Maulidah Hasanah', 'shania.mh@mail.com', NULL);

SELECT * FROM customer;

INSERT INTO amenity(room_type_id, bed_type, size, air_conditioner, refrigerator, microwave, coffe_machine, television, jacuzzi)
VALUES(1, 'Twin', '6x4 m', TRUE , TRUE, TRUE, FALSE, TRUE, FALSE),
(2, 'Queen', '7x4 m', TRUE , TRUE, TRUE, TRUE, TRUE, FALSE),
(3, 'King', '10x5 m', TRUE , TRUE, TRUE, TRUE, TRUE, TRUE);
 
SELECT * FROM amenity;

INSERT INTO reservation(reservation_id, customer_id, reservation_date, start_date, end_date, total_price)
VALUES(1400020317, 2, '2017-09-10 12:00:00+03', '2017-09-10 12:00:00+03', '2017-09-12 13:00:00+03', 1974000),
(1400051317, 3,'2017-10-22 12:00:00+03' , '2017-10-22 12:00:00+03', '2017-10-24 13:00:00+03', 3948000),
(1400021317, 1, '2017-11-01 12:00:00+03', '2017-11-01 12:00:00+03', '2017-11-04 13:00:00+03', 2160000),
(1400051917, 5, '2017-11-17 12:00:00+03', '2017-11-17 12:00:00+03', '2017-11-18 13:00:00+03', 1440000);

SELECT * FROM reservation;

INSERT INTO reservation_room(reservation_id, room_id)
VALUES(1400020317, 206),
(1400051317, 207),
(1400051317, 208),
(1400021317, 109),
(1400051917, 102),
(1400051917, 103);

SELECT * FROM reservation_room;

INSERT INTO payment(payment_id, reservation_id, provider, account_number, payment_status, payment_date, expire_date)
VALUES(290807, 1400020317, 'BNI', '09085567', 'Success', '2017-09-08 12:00:00+03', '2017-09-09 12:00:00+03'),
(310107, 1400051317, 'BCA', '11276912987' , 'Success', '2017-10-10 12:00:00+03', '2017-10-11 12:00:00+03'),
(320207, 1400021317, 'BNI', '09085567', 'Success', '2017-10-20 12:00:00+03', '2017-10-21 12:00:00+03'),
(330307, 1400051917, 'BNI', '09085567', 'Failed', NULL, '2017-11-18 12:00:00+03');

SELECT * FROM payment;
