
CREATE TABLE room(
	room_id integer PRIMARY KEY,
	room_type_id integer,
	room_floor integer,
	availability boolean DEFAULT TRUE
);

CREATE TABLE room_type(
	room_type_id SERIAL PRIMARY KEY,
	name_type varchar(20) NOT NULL UNIQUE,
	max_occupacy integer,
	price numeric, 
	description text
);

CREATE TABLE amenity(
	amenity_id SERIAL PRIMARY KEY,
	room_type_id integer,
	bed_type varchar(20),
	size varchar(25),
	air_conditioner boolean DEFAULT TRUE,
	refrigerator boolean DEFAULT TRUE,
	microwave boolean DEFAULT TRUE,
	coffe_machine boolean DEFAULT TRUE,
	television boolean DEFAULT TRUE,
	jacuzzi boolean DEFAULT TRUE
);

CREATE TABLE customer(
	customer_id SERIAL PRIMARY KEY,
	first_name varchar(100) NOT NULL,
	last_name varchar(100),
	email varchar(100) UNIQUE NOT NULL,
	phone varchar(100),
	UNIQUE(first_name, last_name)
);

CREATE TABLE reservation(
	reservation_id integer PRIMARY KEY,
	customer_id integer,
	reservation_date timestamp, 
	start_date timestamp,
	end_date timestamp,
	total_price numeric
);

CREATE TABLE reservation_room(
	reservation_room_id SERIAL PRIMARY KEY,
	reservation_id integer NOT NULL,
	room_id integer NOT NULL,
	UNIQUE(reservation_id, room_id)
	
);

CREATE TABLE payment(
	payment_id integer PRIMARY KEY,
	reservation_id integer UNIQUE NOT NULL,
	provider varchar(100),
	account_number varchar(100),
	payment_status varchar(20),
	payment_date timestamp,
	expire_date timestamp
);

