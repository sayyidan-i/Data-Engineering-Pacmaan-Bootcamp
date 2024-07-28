SELECT *
FROM products
LIMIT 5;

SELECT DISTINCT(productline)
FROM products;

SELECT productname, buyprice
FROM products
ORDER BY buyprice ASC
LIMIT 5;

SELECT 
		productname, 
		quantityinstock, 
		msrp*0.9 AS saleprice, 
		quantityinstock * msrp * 0.9 AS totalsales
FROM products
ORDER BY productname;

SELECT 
		productname,
		quantityinstock,
		buyprice,
		msrp*0.9 AS salesprice,
		msrp*0.9 - buyprice AS margin,
		(msrp*0.9 - buyprice) * quantityinstock AS revenue
FROM products
ORDER BY (msrp*0.9 - buyprice) * quantityinstock DESC
LIMIT 10;

SELECT *
FROM customers
LIMIT 5;

SELECT *
FROM payments
LIMIT 5;

SELECT customername
FROM customers
WHERE customername LIKE '%Inc%';


SELECT 
        customername, 
        city, 
        country
FROM customers
WHERE city IN ('NYC', 'Brickhaven','San Francisco') OR country = 'Japan';


SELECT 
	customername,
	contactlastname,
	phone,
	country,
	creditlimit
FROM customers
WHERE country = 'USA' AND creditlimit > 0;

SELECT *
FROM payments
ORDER BY amount DESC
LIMIT 10;