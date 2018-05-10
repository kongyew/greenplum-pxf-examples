CREATE EXTENSION pxf;
GRANT INSERT ON PROTOCOL pxf TO gpadmin;
GRANT SELECT ON PROTOCOL pxf TO gpadmin;

CREATE EXTERNAL TABLE pxf_hdfs_textsimple(location text, month text, num_orders int, total_sales float8)
            LOCATION ('pxf://data/pxf_examples/pxf_hdfs_simple.txt?PROFILE=HdfsTextSimple')
          FORMAT 'TEXT' (delimiter=E',');
