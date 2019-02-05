--SELECT * INTO pxf_minio_stocks_parquet1 FROM pxf_minio_stocks;

INSERT INTO pxf_minio_stocks_json SELECT * FROM pxf_minio_stocks;