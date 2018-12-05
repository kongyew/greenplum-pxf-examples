# Greenplum with PXF

PXF provides parallel, high throughput data access and federated queries across heterogeneous data sources via built-in connectors that map a Greenplum Database external table definition to an external data source.

---

### Use Cases

- Read and write text file (Hadoop HDFS)
- Read and write json file (Hadoop HDFS)
- Read and write AVO file (Hadoop HDFS)
- Read data from and write data into external RDBMS
 (Postgresql, Greenplum, Oracle, MySQL)
---

## How to read and write text file
[See this readme](https://github.com/kongyew/greenplum-pxf-examples/blob/master/usecase1/README.MD)

## How to read and write AVRO file
[See this readme](https://github.com/kongyew/greenplum-pxf-examples/blob/master/usecase1/README.MD)


## PXF Architecture
![PXF Architecture Explained](https://gpdb.docs.pivotal.io/5140/pxf/graphics/pxfarch.png)
