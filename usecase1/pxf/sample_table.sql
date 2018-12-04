CREATE EXTENSION pxf;
GRANT INSERT ON PROTOCOL pxf TO gpadmin;
GRANT SELECT ON PROTOCOL pxf TO gpadmin;

CREATE EXTERNAL TABLE pxf_hdfs_textsimple(location text, month text, num_orders int, total_sales float8)
            LOCATION ('pxf://data/pxf_examples/pxf_hdfs_simple.txt?PROFILE=HdfsTextSimple')
          FORMAT 'TEXT' (delimiter=E',');

CREATE EXTERNAL TABLE singleline_json_tbl(
          created_at TEXT,
          id_str TEXT,
          "user.id" INTEGER,
          "user.location" TEXT,
          "coordinates.values[0]" INTEGER,
          "coordinates.values[1]" INTEGER)
          LOCATION('pxf://data/pxf_examples/singleline.json?PROFILE=Json')
          FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');

CREATE EXTERNAL TABLE multiline_json_tbl(
            created_at TEXT,
            id_str TEXT,
            "user.id" INTEGER,
            "user.location" TEXT,
            "coordinates.values[0]" INTEGER,
            "coordinates.values[1]" INTEGER
          )
          LOCATION('pxf://data/pxf_examples/multiline.json?PROFILE=Json&IDENTIFIER=created_at')
          FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');

CREATE EXTERNAL TABLE salesinfo_hiveprofile(location text, month text, num_orders int, total_sales float8)
                      LOCATION ('pxf://default.sales_info?PROFILE=Hive')
                    FORMAT 'custom' (formatter='pxfwritable_import');
