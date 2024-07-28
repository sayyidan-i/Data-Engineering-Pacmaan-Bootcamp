--- Set squence off
set enable_seqscan to off;

---------- Sebelum Index (Query)----------------
SELECT * FROM customer
WHERE phone = '1-591-361-5331';

EXPLAIN SELECT * FROM customer
WHERE phone = '1-591-361-5331';

-------Single Index-----------
CREATE INDEX idx_customer_phone 
ON customer USING btree(phone);

--DROP INDEX idx_customer_phone 

EXPLAIN SELECT * FROM customer
WHERE phone = '1-591-361-5331';



-------Composite Index------------
CREATE INDEX idx_customer_name
ON customer(first_name, last_name);

--DROP INDEX idx_customer_id 

EXPLAIN SELECT * FROM customer
WHERE first_name = 'Cedric' and last_name = 'Marks';


--------list index
SELECT
    tablename,
    indexname,
    indexdef
FROM
    pg_indexes
WHERE
    schemaname = 'public'
ORDER BY
    tablename,
    indexname;
	
	
	


