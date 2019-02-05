-- Create a function to access the S3 protocol library
CREATE OR REPLACE FUNCTION read_from_s3() RETURNS integer AS
    '$libdir/gps3ext.so', 's3_import' LANGUAGE C STABLE;

-- Declare the S3 protocol and specify the function that is used
-- to read from an S3 bucket
CREATE PROTOCOL s3 (
    readfunc  = read_from_s3
);

drop external table stock_fact_external;

CREATE EXTERNAL TABLE stock_fact_external (
stock text,
stock_date text,
price text
)
LOCATION('s3://minio1:9000/testbucket/stocks.csv config=/home/gpadmin/s3.conf')
FORMAT 'TEXT'(DELIMITER=',');


-- query external s3 table
select count(*) from stock_fact_external;


CREATE WRITABLE EXTERNAL TABLE S3WRIT (LIKE stock_fact_external)
   LOCATION('s3://minio1:9000/testbucket/
      config=/home/gpadmin/s3.conf')
   FORMAT 'csv';

-- https://discuss.pivotal.io/hc/en-us/articles/235063748-Troubleshooting-Guide-Configuring-Amazon-S3-with-Greenplum
drop external table stock_fact_external;



Your configuration works well.
$ gpcheckcloud -c "s3://minio1:9000/testbucket config=/home/gpadmin/s3.conf"
File: read_stocks.sql, Size: 911
File: stocks.csv, Size: 12246
File: testdata.csv, Size: 138

Your configuration works well.
$  psql
psql (8.3.23)
Type "help" for help.

gpadmin=# drop external table stock_fact_external;
DROP EXTERNAL TABLE
gpadmin=#
gpadmin=# CREATE EXTERNAL TABLE stock_fact_external (
gpadmin(# stock text,
gpadmin(# stock_date text,
gpadmin(# price text
gpadmin(# )
s3.conf') LOCATION('s3://minio1:9000/testbucket/stocks.csv config=/home/gpadmin/
gpadmin-# FORMAT 'TEXT'(DELIMITER=',');
CREATE EXTERNAL TABLE
gpadmin=# select count(*) from stock_fact_external;
 count
-------
   561
(1 row)

gpadmin=# select count(*) from stock_fact_external;
 count
-------
   561
(1 row)
