DROP TABLE sales_info;
CREATE TABLE sales_info (location string, month string,
        number_of_orders int, total_sales double)
        ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
        STORED AS textfile;

Load data local inpath 'pxf_hive_datafile.txt' into table sales_info
