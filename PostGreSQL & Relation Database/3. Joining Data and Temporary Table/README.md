# Joining Data and Temporary Table


## Relation in Database
Untuk mengakses data dari dua tabel yang berbeda, diperlukan relasi antara kedua tabel tersebut.

Dua buah tabel dapat berelasi jika:
1. Terdapat kolom yang nilainya sama antara dua tabel atau lebih    
2. Kedua tabel dibuatkan relasinya saat proses pembuatan tabel.

Untuk melihat relasi semua table di dalam database dapat menggunakan Entity Relationship Diagram (ERD). ERD adalah diagram yang menggambarkan hubungan antara entitas dalam database. ERD terdiri dari entitas, atribut, dan relasi antar entitas.

![alt text](image.png)

- Tabel Relation
    
    - Kolom yang menghubungkan dua tabel disebut dengan Key
    - Key yang berada di tabel utama disebut Primary Key
    - Key yang berada di tabel kedua disebut Foreign Key 


## Joins

Joins adalah operasi yang digunakan untuk menggabungkan dua tabel berdasarkan kolom yang memiliki nilai yang sama. Terdapat beberapa jenis join, yaitu:

1. `Inner Join` mengembalikan data yang memiliki nilai yang sama di kedua tabel.

    ![alt text](image-1.png)

    ```sql
    SELECT column_name(s)
    FROM table1
    INNER JOIN table2
    ON table1.column_name = table2.column_name;
    ```
2. `Left Join` mengembalikan semua data dari tabel kiri dan digabungkan dengan data yang memiliki nilai yang sama di tabel kanan. Data yang tidak memiliki nilai akan diisi dengan NULL.


    ![alt text](image-2.png)

    ```sql
    SELECT column_name(s)
    FROM table1
    LEFT JOIN table2
    ON table1.column_name = table2.column_name;
    ```

3. `Right Join` mengembalikan semua data dari tabel kanan dan digabungkan dengan data yang memiliki nilai yang sama di tabel kiri. Data yang tidak memiliki nilai akan diisi dengan NULL.

    ![alt text](image-3.png)

    ```sql
    SELECT column_name(s)
    FROM table1
    RIGHT JOIN table2
    ON table1.column_name = table2.column_name;
    ```


## Sub Query

Sub Query adalah query yang berada di dalam query lain. Sub Query dapat digunakan untuk mencari data yang akan digunakan untuk filtering. Contoh: kita ingin mengembalikan data yang memiliki salary diatas rata-rata. Untuk mencari nilai salary rata-rata, kita dapat menggunakan Sub Query.

- Contoh kasus

    - Perusahaan ingin mencari siapa saja customer yang nilai transaksinya diatas rata-rata. Apabila kita menghitung rata-rata transaksi terlebih dahulu, hasilnya tidak akan representatif karena ketika data bertambah maka rata-rata akan berubah. Oleh karena itu, kita dapat menggunakan Sub Query untuk mencari nilai rata-rata transaksi.

    ```sql
    SELECT id_customer, tgl_transaksi, jumlah_pembayaran
    FROM payments
    WHERE jumlah_pembayaran > (SELECT AVG(jumlah_pembayaran) avg_transaksi FROM payments);
    ```

    - Bagaimana jika kita ingin mencari nilai minimum dari hasil sebelumnya? Kita dapat memasukkan query sebelumnya sebagai sub query dari query baru untuk mencari nilai minimum.

    ```sql
        SELECT MIN(jumlah_pembayaran)
        FROM (
            SELECT id_customer, tgl_transaksi, jumlah_pembayaran
            FROM payments
            WHERE jumlah_pembayaran > (
                SELECT AVG(jumlah_pembayaran) avg_transaksi
                FROM payments
            )
        ) AS transac_above_avg;
    ```

    > Notes: Sub query pada klausa from biasa disebut derived table dan membutuhkan alias pada saat dibuat.


    Dengan demikian, Sub Query dapat ditempatkan pada:
    - Klausa `WHERE` sebagai parameter filter
    - Klausa `FROM` / `JOIN` sebagai tabel acuan