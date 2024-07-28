-- Membuat tabel product --
CREATE TABLE product(
	product_id integer PRIMARY KEY,
	product_category_id integer,
	product_brand_id integer,
	name varchar(255) UNIQUE NOT NULL,
	description text,
	price numeric,
	stock numeric,
	image bytea
);

-- Membuat tabel product kategori mengunakan serial ----
CREATE TABLE product_category(
	product_category_id SERIAL PRIMARY KEY,
	name varchar(255) UNIQUE NOT NULL,
	description text
);

-- Membuat tabel product brand menguunakan default ----
CREATE TABLE product_brand(
	product_brand_id SERIAL PRIMARY KEY,
	name varchar(255) UNIQUE NOT NULL,
	description text DEFAULT 'No description'
);

CREATE TABLE customer(
	customer_id SERIAL PRIMARY KEY,
	username varchar(20) UNIQUE NOT NULL,
	first_name varchar(255) NOT NULL,
	last_name varchar(255),
	email varchar(255) UNIQUE NOT NULL,
	phone varchar(20)
);

CREATE TABLE customer_address(
	cust_address_id SERIAL PRIMARY KEY,
	customer_id integer NOT NULL,
	address text,
	provincy varchar(255),
	city varchar(255),
	district varchar(255),
	postal_code varchar(20),
	phone varchar(20)
);

CREATE TABLE customer_payment(
	cust_payment_id SERIAL PRIMARY KEY,
	customer_id integer NOT NULL,
	payment_type varchar(255),
	provider varchar(255),
	account_no varchar(255),
	expire_date date

);

CREATE TABLE orders(
	order_id SERIAL PRIMARY KEY,
	customer_id integer NOT NULL,
	order_status varchar(20),
	created timestamp
);

CREATE TABLE order_detail(
	order_detail_id SERIAL PRIMARY KEY,
	order_id integer NOT NULL,
	product_id integer NOT NULL,
	quantity numeric,
	total_price numeric
);

CREATE TABLE order_payment(
	order_payment_id SERIAL PRIMARY KEY,
	order_id integer UNIQUE NOT NULL,
	payment_amount numeric,
	provider varchar(255),
	account_number varchar(255),
	payment_status varchar(20),
	payment_date timestamp,
	expire_date timestamp
);


CREATE TABLE order_shipment(
	order_shipment_id SERIAL PRIMARY KEY,
	order_id integer UNIQUE NOT NULL,
	tracking_number varchar(255),
	provider varchar(255),
	shipment_date timestamp,
	shipment_status varchar(20)
);
