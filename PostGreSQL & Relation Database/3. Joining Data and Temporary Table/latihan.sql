

-- find stuff that never ordered
SELECT 
        productname, 
        productline,
        quantityordered
    FROM products
    LEFT JOIN orderdetails
    ON products.productcode = orderdetails.productcode
    WHERE quantityordered IS NULL;


-- barang dengan persentase terjual kurang dari 20%
-- total stok = stok saat ini + jumlah terjual

-- Tabel yang memiliki informasi jumlah stok dan jumlah terjual adalah tabel `products` dan `orderdetails`
	-- hitung setiap produk terjual berapa
    -- hitung total stok
    -- hitung persentase terjual -> terjual / total stok * 100%
    -- filter barang yang persentase terjualnya kurang dari 30%

--hitung setiap produk terjual berapa
DROP TABLE IF EXISTS totalordered;

CREATE TEMPORARY TABLE totalordered AS
	SELECT productcode, SUM(quantityordered) as totalquantityordered
	FROM orderdetails
	GROUP BY productcode;

SELECT * FROM totalordered
LIMIT 10;

-- create total stock table
DROP TABLE IF EXISTS totalstock;
CREATE TEMPORARY TABLE totalstock AS
SELECT pro.productcode, tts.totalquantityordered, pro.quantityinstock + tts.totalquantityordered AS total_stock
FROM products AS pro
LEFT JOIN totalordered AS tts
ON pro.productcode = tts.productcode;

SELECT * FROM totalstock
LIMIT 10;

-- hitung persentase terjual
SELECT 
	pro.productname, 
	pro.productline, 
	tts.totalquantityordered, 
	tts.total_stock, 
	(CAST(tts.totalquantityordered AS FLOAT) / CAST(tts.total_stock AS FLOAT)) * 100 AS orderpercentage
FROM products pro
JOIN totalstock tts
	ON pro.productcode = tts.productcode
WHERE (CAST(tts.totalquantityordered AS FLOAT) / CAST(tts.total_stock AS FLOAT)) * 100 < 30
ORDER BY orderpercentage;


-- mencari produk mana yang udah pernah dijual dengan harga kurang dari harga minimal (20% dibawah MSRP)
-- bikin temporary table harga terendah yang pernah dijual untuk setiap produk
-- gabungkan tabel temp dengan product, filter cuma yang pernah dijual kurang dari harga minimal

DROP TABLE IF EXISTS minprice;
CREATE TEMPORARY TABLE minprice AS
SELECT productcode, MIN(priceeach) AS sellprice
FROM orderdetails
GROUP BY productcode;

SELECT * 
FROM minprice
LIMIT 10;

SELECT 
	productname, 
	productline, 
	msrp, 
	0.8*msrp AS minsellprice, 
	sellprice/msrp * 100 AS price_percentage
FROM products
LEFT JOIN minprice
ON products.productcode = minprice.productcode
WHERE sellprice/msrp * 100 < 80
ORDER BY sellprice/msrp * 100;

-- Dari penjualan yang telah dilakukan, pemilik toko ingin mengetahui 
-- kategori produk mana yang penjualannya di atas rata-rata.
    -- gabungkan tabel product dan orderdetail dan buat tabel untuk mencari total penjualan dari setiap kategori produk.
    -- hitung rata-rata semua penjualan
    -- filter kategori produk yang penjualannya diatas rata-rata.

CREATE TEMPORARY TABLE kategoriproduk AS
SELECT 
	products.productline, 
	SUM(orderdetails.quantityordered)
FROM products
LEFT JOIN orderdetails
ON products.productcode = orderdetails.productcode
GROUP BY products.productline;

SELECT * from kategoriproduk

-- filter dengan subquery
SELECT 
	productline,
	sum
FROM kategoriproduk
WHERE sum > (SELECT avg(sum) FROM kategoriproduk)


-- CASE 2
-- Berapa rata-rata payment yang dilakukan oleh customer


CREATE TEMPORARY TABLE avgAmountEachCustomer AS
SELECT customernumber, AVG(amount) as avgamountspent
FROM payments
GROUP BY customernumber;

SELECT customername, phone, city, state, country, avgamountspent
FROM customers
JOIN avgAmountEachCustomer
ON customers.customernumber = avgAmountEachCustomer.customernumber
ORDER BY avgamountspent DESC;


SELECT ctm.customername, prd.productname, SUM(quantityordered)
FROM orderdetails ordd
JOIN orders ord
	ON ordd.ordernumber = ord.ordernumber
JOIN customers ctm
	ON ctm.customernumber = ord.customernumber
JOIN products prd
	ON prd.productcode = ordd.productcode
GROUP BY customername, productname;

WITH totalpaymentpercustomer AS (
	SELECT customernumber, SUM(amount) as totalpayment
	FROM payments
	GROUP BY 1
)

SELECT customername, country, totalpayment
FROM customers
JOIN totalpaymentpercustomer
USING (customernumber)
WHERE totalpayment > (SELECT AVG(totalpayment) FROM totalpaymentpercustomer);

WITH salestotalsales AS (
	SELECT salesrepemployeenumber, SUM(quantityordered*priceeach) AS totalsales
	FROM customers
	JOIN orders
		USING (customernumber)
	JOIN orderdetails
		USING (ordernumber)
	WHERE EXTRACT (YEAR FROM orderdate) = 2004 AND status = 'Shipped'
	GROUP BY 1
	ORDER BY 2 DESC
	LIMIT 5
)

SELECT CONCAT(firstname, ' ', lastname) employeeName, email, totalsales
FROM employees
JOIN salestotalsales
	ON employees.employeenumber = salestotalsales.salesrepemployeenumber
ORDER BY 3 DESC;