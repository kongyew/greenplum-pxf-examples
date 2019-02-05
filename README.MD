#  Readme
This repository provides examples to use Greenplum with PXF.

[![Build Status](https://travis-ci.org/kongyew/greenplum-pxf-examples.svg?branch=master)](https://travis-ci.org/kongyew/greenplum-pxf-examples)
[![GitPitch](https://gitpitch.com/assets/badge.svg)](https://gitpitch.com/kongyew/greenplum-pxf-examples)

# Greenplum
Greenplum Database® is an advanced, fully featured, open source data platform.  It provides powerful and rapid analytics on petabyte scale data volumes.  Uniquely geared toward big data analytics, Greenplum Database is powered by the world’s most advanced cost-based query optimizer delivering high analytical query performance on large data volumes.
<https://greenplum.org/>


# Use Cases:
1. [Read text data from HDFS](usecase1/README.MD)
2. [Read JSON data from HDFS](usecase1/READMEJSON.MD)
3. [Read HIVE Table data](#read-HIVE-Table-data)
4. [Read data from external SQL database](#Read-data-from-external-SQL-database)
5. [Read and write data into Minio ](#Read-data-from-Minio-or-write-data-into-Minio)




## Read data from HDFS
This example uses Greenplum with PXF to read data from HDFS.

For more details see [README](usecase1/README.MD)

## Read HIVE Table data
This example uses Greenplum with PXF to read HIVE Table from HDFS.

For more details see [README](usecase1/README.MD)

## Read data from external SQL database
This example uses Greenplum with PXF to read data from external SQL database (Postgresql)

For more details see [README](usecase2/README.MD)

## Read data from Minio or write data into Minio
This example uses Greenplum with PXF to access data on Minio

For more details see [README](usecase8/README.MD)