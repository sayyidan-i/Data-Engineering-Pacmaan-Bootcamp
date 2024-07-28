CREATE TABLE city(
	city_id integer PRIMARY KEY,
	name varchar(255) NOT NULL UNIQUE
);

CREATE TABLE restaurant(
	restaurant_id SERIAL PRIMARY KEY,
	name varchar(255) NOT NULL,
	email varchar(255) NOT NULL UNIQUE,
	phone_number varchar(20) NOT NULL,
	address text NOT NULL,
	city_id int NOT NULL,
	coordinate point NOT NULL,
	password varchar(255) NOT NULL,
	CONSTRAINT fk_restaurant_city
		FOREIGN KEY(city_id)
		REFERENCES city(city_id) 
);

CREATE TABLE food(
	food_id SERIAL PRIMARY KEY,
	restaurant_id int NOT NULL,
	food_name varchar(255) NOT NULL,
	price numeric NOT NULL CHECK(price > 0),
	description text NOT NULL,
	availability boolean NOT NULL DEFAULT TRUE,
	CONSTRAINT fk_food_resataurant
		FOREIGN KEY(restaurant_id)
		REFERENCES restaurant(restaurant_id)
);

CREATE TABLE users(
	user_id SERIAL PRIMARY KEY,
	username varchar(20) UNIQUE NOT NULL,
	first_name varchar(255) NOT NULL,
	last_name varchar(255),
	email varchar(255) UNIQUE NOT NULL,
	phone_number varchar(20) NOT NULL,
	address text NOT NULL,
	city_id int NOT NULL,
	coordinate point NOT NULL,
	password varchar(255) NOT NULL,
	CONSTRAINT fk_user_city
		FOREIGN KEY(city_id)
		REFERENCES city(city_id)
);

CREATE TABLE driver(
	driver_id SERIAL PRIMARY KEY,
	username varchar(20) UNIQUE NOT NULL,
	first_name varchar(255) NOT NULL,
	last_name varchar(255) NOT NULL,
	email varchar(255) UNIQUE NOT NULL,
	phone_number varchar(20) NOT NULL,
	drivers_license varchar(15) NOT NULL,
	city_id int NOT NULL,
	license_plate varchar(20) NOT NULL,
	password varchar(255) NOT NULL,
	CONSTRAINT fk_driver_city
		FOREIGN KEY(city_id)
		REFERENCES city(city_id)
);

CREATE TABLE driver_coordinate(
	driver_coordinate_id SERIAL PRIMARY KEY,
	driver_id int NOT NULL,
	created_at timestamp NOT NULL,
	coordinate point NOT NULL,
	CONSTRAINT fk_driver_coordinate
		FOREIGN KEY(driver_id)
		REFERENCES driver(driver_id)
);

CREATE TABLE order_status(
	order_status_id SERIAL PRIMARY KEY,
	status varchar(20) UNIQUE NOT NULL
);

CREATE TABLE orders(
	order_id SERIAL PRIMARY KEY,
	user_id int NOT NULL,
	driver_id int,
	created_at timestamp NOT NULL,
	delivery_charge numeric NOT NULL CHECK(delivery_charge >= 0),
	review text,
	CONSTRAINT fk_order_user
		FOREIGN KEY(user_id)
		REFERENCES users(user_id),
	CONSTRAINT fk_order_driver
		FOREIGN KEY(driver_id)
		REFERENCES driver(driver_id)
);

CREATE TABLE order_detail(
	order_detail_id SERIAL PRIMARY KEY,
	order_id int NOT NULL,
	food_id int NOT NULL,
	qty numeric NOT NULL CHECK(qty > 0),
	is_like boolean,
	CONSTRAINT fk_order_detail
		FOREIGN KEY(order_id)
		REFERENCES orders(order_id),
	CONSTRAINT fk_order_food
		FOREIGN KEY(food_id)
		REFERENCES food(food_id)
);

CREATE TABLE order_status_log(
	order_status_log SERIAL PRIMARY KEY,
	order_id int NOT NULL,
	order_status_id int NOT NULL,
	created_at timestamp NOT NULL,
	CONSTRAINT fk_order_status
		FOREIGN KEY(order_id)
		REFERENCES orders(order_id),
	CONSTRAINT fk_status_type
		FOREIGN KEY(order_status_id)
		REFERENCES order_status(order_status_id)
);

CREATE INDEX idx_food_name
ON food USING btree(food_name);

CREATE INDEX idx_driver_coordinate
ON driver_coordinate USING gist(coordinate);
