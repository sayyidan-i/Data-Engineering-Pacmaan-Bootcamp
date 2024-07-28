-------- Create List Partition -----------
CREATE TABLE sales_region(
	sales_region_id int, 
	amount numeric, 
	branch text, 
	region text
)PARTITION BY LIST (region);

CREATE TABLE Jakarta PARTITION OF sales_region FOR VALUES IN ('Jakarta');
CREATE TABLE Bandung PARTITION OF sales_region FOR VALUES IN ('Bandung');
CREATE TABLE Surabaya PARTITION OF sales_region FOR VALUES IN ('Surabaya');


INSERT INTO sales_region (sales_region_id, amount, branch, region)
VALUES
  (1, 1000, 'Branch A', 'Jakarta'),
  (2, 2000, 'Branch B', 'Bandung'),
  (3, 1500, 'Branch C', 'Surabaya'),
  (4, 3000, 'Branch D', 'Jakarta'),
  (5, 1200, 'Branch E', 'Bandung'),
  (6, 2500, 'Branch F', 'Surabaya'),
  (7, 1800, 'Branch G', 'Jakarta'),
  (8, 3500, 'Branch H', 'Bandung'),
  (9, 800, 'Branch I', 'Surabaya'),
  (10, 1700, 'Branch J', 'Jakarta'),
  (11, 1100, 'Branch K', 'Bandung'),
  (12, 2800, 'Branch L', 'Surabaya');
  
SELECT * FROM sales_region;
SELECT * FROM Bandung;



-------- Create List Partition -----------
CREATE TABLE sales(
	sales_id int, 
	product_name text, 
	amount int, 
	sale_date date
)PARTITION BY RANGE (sale_date);

CREATE TABLE sales_2020_Q4 PARTITION OF sales FOR VALUES FROM ('2020-10-01') TO ('2021-01-01');
CREATE TABLE sales_2020_Q3 PARTITION OF sales FOR VALUES FROM ('2020-07-01') TO ('2020-10-01');
CREATE TABLE sales_2020_Q2 PARTITION OF sales FOR VALUES FROM ('2020-04-01') TO ('2020-07-01');
CREATE TABLE sales_2020_Q1 PARTITION OF sales FOR VALUES FROM ('2020-01-01') TO ('2020-04-01');

INSERT INTO sales (sales_id, product_name, amount, sale_date)
VALUES 
  (1, 'Product A', 100, '2020-01-01'),
  (2, 'Product B', 200, '2020-01-05'),
  (3, 'Product C', 150, '2020-02-10'),
  (4, 'Product A', 120, '2020-03-15'),
  (5, 'Product D', 80, '2020-04-20'),
  (6, 'Product E', 300, '2020-05-25'),
  (7, 'Product C', 220, '2020-06-30'),
  (8, 'Product F', 180, '2020-07-12'),
  (9, 'Product G', 250, '2020-08-18'),
  (10, 'Product G', 250, '2020-11-18');
  
SELECT * FROM sales;
SELECT * FROM sales_2020_Q3;

----- HASH Partition
CREATE TABLE employee(
	employee_id int,
 	full_name text, 
	departement_code int
)PARTITION BY HASH (employee_id);

CREATE TABLE emp_0 PARTITION OF employee FOR VALUES WITH (MODULUS 3,REMAINDER 0);
CREATE TABLE emp_1 PARTITION OF employee FOR VALUES WITH (MODULUS 3,REMAINDER 1);
CREATE TABLE emp_2 PARTITION OF employee FOR VALUES WITH (MODULUS 3,REMAINDER 2);

INSERT INTO employee (employee_id, full_name, departement_code) VALUES
  (1, 'John Doe', 101),
  (2, 'Jane Smith', 102),
  (3, 'Bob Johnson', 101),
  (4, 'Mary Adams', 103),
  (5, 'Tom Wilson', 102),
  (6, 'Sara Lee', 101),
  (7, 'Mike Brown', 103),
  (8, 'Lisa Davis', 102),
  (9, 'Jim Wilson', 101),
  (10, 'Karen Thompson', 103);
  
SELECT * FROM emp_0;


----- Composite Partition
CREATE TABLE sales_date (
   transaction_date DATE NOT NULL,
   region VARCHAR(50) NOT NULL,
   amount NUMERIC NOT NULL
)PARTITION BY RANGE(transaction_date);

CREATE TABLE sales_202201 PARTITION OF sales_date
    FOR VALUES FROM ('2022-01-01') TO ('2022-02-01') PARTITION BY LIST(region);
CREATE TABLE sales_202202 PARTITION OF sales_date
    FOR VALUES FROM ('2022-02-01') TO ('2022-03-01') PARTITION BY LIST(region);
	
CREATE TABLE sales_202201_usa PARTITION OF sales_202201
    FOR VALUES IN ('USA');
CREATE TABLE sales_202201_europe PARTITION OF sales_202201
    FOR VALUES IN ('Europe');
CREATE TABLE sales_202202_usa PARTITION OF sales_202202
    FOR VALUES IN ('USA');
CREATE TABLE sales_202202_europe PARTITION OF sales_202202
    FOR VALUES IN ('Europe');

INSERT INTO sales_date(transaction_date, region, amount) VALUES
    ('2022-01-01', 'USA', 1000.00),
    ('2022-01-02', 'Europe', 2000.00),
    ('2022-02-01', 'USA', 1500.00),
    ('2022-02-03', 'Europe', 2500.00),
    ('2022-02-11', 'USA', 1200.00),
    ('2022-02-16', 'Europe', 2200.00);

SELECT * FROM sales_202202_usa;
SELECT * FROM sales_date;


---- DEFAULT value
CREATE TABLE region_default PARTITION OF sales_region DEFAULT;
INSERT INTO sales_region (sales_region_id, amount, branch, region)
VALUES(13, 1000, 'Branch A', 'Semarang');

SELECT * FROM region_default;

