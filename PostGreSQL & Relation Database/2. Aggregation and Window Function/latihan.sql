-- Aggregation Case

-- Mencari ketersediaan stock dengan mencari jumlah totalnya
SELECT SUM(quantityinstock) AS TotalStock
FROM products;

-- Mencari jumlah variasi barang kurang dari 5 berdasarkan jenis produk yang dijual
-- count distinct productname, groupby productline, having productline <5
SELECT productline, COUNT(DISTINCT(productname)) AS productcount
FROM products
GROUP BY productline
HAVING COUNT(DISTINCT(productname)) < 5;

-- Membandingkan stock barang dengan rata-ratanya
SELECT 
	productname, 
	quantityinstock, 
	AVG(quantityinstock)
FROM products
GROUP BY productname, quantityinstock;


-- Membandingkan stock barang dengan rata-rata stock secara keseluruhan

SELECT
	productname,
	quantityinstock,
	AVG(quantityinstock) OVER() AS AvgStock
FROM products;

-- Jika ingin membandingkan stock barang sesuai dengan productlinenya
SELECT
	productname,
	productline,
	quantityinstock,
	AVG(quantityinstock) OVER(PARTITION BY productline) AS AvgStock
FROM products;


-- perbandingan harga dan kuantitas pembelian barang
-- apakah semakin mahal barang semakin sedikit yang beli dan sebaliknya?
-- lihat pada tabel orderdetails

-- productcode, priceeach, quantityordered, dense rank price each desc, dense rank quantity asc

SELECT 
	productcode,
	priceeach,
	quantityordered,
	DENSE_RANK() OVER(ORDER BY priceeach DESC) AS pricerank,
	DENSE_RANK() OVER(ORDER BY quantityordered ASC) AS qtyrank
FROM orderdetails
ORDER BY qtyrank;


SELECT
	*
FROM payments;

-- mencari next paymentdate dan next amount menggunakan lead()
SELECT
	customernumber,
	paymentdate,
	amount,
 	LEAD(paymentdate,1) OVER(PARTITION BY customernumber 
		ORDER BY paymentdate ASC RANGE BETWEEN UNBOUNDED PRECEDING 
		AND CURRENT ROW) AS nextpaymentdate,
	LEAD(amount,1) OVER(PARTITION BY customernumber
		ORDER BY paymentdate ASC RANGE BETWEEN UNBOUNDED PRECEDING
		AND CURRENT ROW) AS nextamount
FROM payments;


-- mencari barang termahal ke-N menggunakan NTH_VALUE

SELECT
	productname,
	productline,
	buyprice,
	NTH_VALUE(productname, 2) OVER(PARTITION BY productline ORDER BY buyprice DESC
	RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS second_most_expensive_product, 
	NTH_VALUE(buyprice, 2) OVER(PARTITION BY productline ORDER BY buyprice DESC
	RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS second_most_expensive
FROM products;


SELECT
	productname,
	productline,
	buyprice,
	NTH_VALUE(productname, 4) OVER(PARTITION BY productline ORDER BY buyprice DESC
	RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS fourth_most_expensive_product, 
	NTH_VALUE(buyprice, 4) OVER(PARTITION BY productline ORDER BY buyprice DESC
	RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS fourth_most_expensive
FROM products;