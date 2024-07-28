-- Membuat tabel product kategori mengunakan serial ----
CREATE TABLE product_category(
	product_category_id SERIAL PRIMARY KEY,
	name varchar(255) UNIQUE NOT NULL,
	description text DEFAULT 'No description'
);

-- Membuat tabel product brand menguunakan default ----
CREATE TABLE product_brand(
	product_brand_id SERIAL PRIMARY KEY,
	name varchar(255) UNIQUE NOT NULL,
	description text DEFAULT 'No description'
);


-- Membuat tabel product --
CREATE TABLE product(
	product_id integer PRIMARY KEY,
	product_category_id integer NOT NULL,
	product_brand_id integer NOT NULL,
	name varchar(255) UNIQUE NOT NULL,
	description text,
	price numeric NOT NULL CHECK (price >= 0),
	stock numeric NOT NULL CHECK (price >= 0),
	image bytea,
	CONSTRAINT fk_product_category
		FOREIGN KEY(product_category_id)
		REFERENCES product_category(product_category_id)
		ON DELETE RESTRICT,
	CONSTRAINT fk_product_brand
		FOREIGN KEY(product_brand_id)
		REFERENCES product_brand(product_brand_id)
		ON DELETE RESTRICT
);


CREATE TABLE customer(
	customer_id SERIAL PRIMARY KEY,
	username varchar(20) UNIQUE NOT NULL,
	first_name varchar(255) NOT NULL,
	last_name varchar(255),
	email varchar(255) UNIQUE NOT NULL,
	phone varchar(20) NOT NULL
);

CREATE TABLE customer_address(
	cust_address_id SERIAL PRIMARY KEY,
	customer_id integer NOT NULL,
	address text NOT NULL,
	provincy varchar(255) NOT NULL,
	city varchar(255) NOT NULL,
	district varchar(255) NOT NULL,
	postal_code varchar(20)NOT NULL,
	phone varchar(20) NOT NULL,
	CONSTRAINT fk_customer_address
		FOREIGN KEY(customer_id)
		REFERENCES customer(customer_id)
		ON DELETE CASCADE
);

CREATE TABLE customer_payment(
	cust_payment_id SERIAL PRIMARY KEY,
	customer_id integer NOT NULL,
	payment_type varchar(255) NOT NULL,
	provider varchar(255) NOT NULL,
	account_no varchar(255) NOT NULL,
	expire_date date NOT NULL,
	CONSTRAINT fk_customer_payment
		FOREIGN KEY(customer_id)
		REFERENCES customer(customer_id)
		ON DELETE CASCADE
);

CREATE TABLE orders(
	order_id SERIAL PRIMARY KEY,
	customer_id integer NOT NULL,
	order_status varchar(20) NOT NULL,
	created timestamp NOT NULL,
	CONSTRAINT fk_customer_order
		FOREIGN KEY(customer_id)
		REFERENCES customer(customer_id)
);

CREATE TABLE order_detail(
	order_detail_id SERIAL PRIMARY KEY,
	order_id integer NOT NULL,
	product_id integer NOT NULL,
	quantity numeric NOT NULL CHECK (quantity > 0),
	total_price numeric,
	CONSTRAINT fk_detail_order
		FOREIGN KEY(order_id)
		REFERENCES orders(order_id)
		ON DELETE RESTRICT,
	CONSTRAINT fk_detail_product
		FOREIGN KEY(product_id)
		REFERENCES product(product_id)
		ON DELETE RESTRICT
);

CREATE TABLE order_payment(
	order_payment_id SERIAL PRIMARY KEY,
	order_id integer UNIQUE NOT NULL,
	payment_amount numeric NOT NULL,
	provider varchar(255) NOT NULL,
	account_number varchar(255) NOT NULL,
	payment_status varchar(20) NOT NULL,
	payment_date timestamp,
	expire_date timestamp,
	CONSTRAINT fk_order_payment
		FOREIGN KEY(order_id)
		REFERENCES orders(order_id)
		ON DELETE CASCADE
);


CREATE TABLE order_shipment(
	order_shipment_id SERIAL PRIMARY KEY,
	order_id integer UNIQUE NOT NULL,
	tracking_number varchar(255) NOT NULL,
	provider varchar(255) NOT NULL,
	shipment_date timestamp,
	shipment_status varchar(20),
	CONSTRAINT fk_order_shipment
		FOREIGN KEY(order_id)
		REFERENCES orders(order_id)
		ON DELETE CASCADE
);
