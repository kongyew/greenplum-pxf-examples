CREATE EXTENSION pxf;
GRANT INSERT ON PROTOCOL pxf TO gpadmin;
GRANT SELECT ON PROTOCOL pxf TO gpadmin;



CREATE EXTERNAL TABLE pxf_minio_stocks(stock text,
stock_date text,
price text)
  LOCATION ('pxf://testbucket/stocks.csv?PROFILE=s3:text&SERVER=minioserver')
FORMAT 'TEXT' (DELIMITER=',');


CREATE WRITABLE EXTERNAL TABLE pxf_minio_stocks_parquet(stock text,
stock_date text,
price text)
  LOCATION ('pxf://testbucket/stocks_parquet.csv?PROFILE=s3:parquet&SERVER=minioserver')
  FORMAT 'CUSTOM' (FORMATTER='pxfwritable_export');


CREATE WRITABLE EXTERNAL TABLE pxf_minio_stocks_json(stock text,
stock_date text,
price text)
  LOCATION ('pxf://testbucket/stocks_json.csv?PROFILE=s3:json&SERVER=minioserver')
  FORMAT 'CUSTOM' (FORMATTER='pxfwritable_export');

