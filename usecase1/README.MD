#  Greenplum
The  Greenplum Database (GPDB) is an advanced, fully featured, open source data warehouse. It provides powerful and rapid analytics on petabyte scale data volumes. Uniquely geared toward big data analytics, Greenplum Database is powered by the world’s most advanced cost-based query optimizer delivering high analytical query performance on large data volumes.
<https://www.greenplum.org>

# How to use Greenplum with PXF to read data from Hadoop (Cloudera)
This [repository](https://github.com/kongyew/greenplum-pxf-examples/tree/master/usecase1) demonstrates how to use Greenplum with PXF to read text data from hadoop.

# Table of Contents
1. [Pre-requisites](#Pre-requisites)
2. [Start Docker-compose](#Start-Docker-compose)
3. [Configure Greenplum](#Configure-Greenplum)
4. [Configure Cloudera](#Configure-Cloudera)
5. [Use PSQL to read data via PXF](#Use-PSQL-to-read-data-via-PXF)
## Pre-requisites:
- **8GB memory or more** allocated to docker
- [docker-compose](http://docs.docker.com/compose)
- [Cloudera docker image](https://hub.docker.com/r/cloudera/quickstart/)
- [GPDB 5.x docker image](https://hub.docker.com/r/kochanpivotal/gpdb5oss/)

## Start Docker compose
Once you have cloned this repository, you can run the command  `./runDocker.sh -t usecase1 -c up`, in order to start both Greenplum and Cloudera docker instances.

The assumption: docker and docker-compose are already installed on your machine.

### Run command to start both Greenplum and Cloudera instances
```
$ ./runDocker.sh -t usecase1 -c up
WARNING: Found orphan containers (postgresql) for this project. If you removed or renamed this service in your compose file, you can run this command with the --remove-orphans flag to clean it up.
Recreating gpdbsne ... done
Recreating quickstart.cloudera ... done
Attaching to gpdbsne, quickstart.cloudera
gpdbsne     | /etc/sysconfig/run-parts
gpdbsne     | /usr/bin/run-parts
gpdbsne     | Running /docker-entrypoint.d
gpdbsne     | /docker-entrypoint.d/startInit.sh:
gpdbsne     |
gpdbsne     | init is running
gpdbsne     | /docker-entrypoint.d/startSSH.sh:
```
### How to access Greenplum docker instance:
You can use this command `docker exec -it gpdbsne bin/bash` to access Greenplum docker instance. Or you can run this script `accessDockerGPDBSNE.sh`.

For example:
```
$ docker exec -it gpdbsne bin/bash
[root@gpdbsne /]#

```

## Configure Greenplum
Once you have access to Greenplum docker instance, you can create database, table with some sample data.

1. Use gpadmin user by using `su - gpadmin`
2. Disable user impersonation by editing /usr/local/greenplum-db/pxf/conf/pxf-env.sh
```
[gpadmin@gpdbsne conf]$ vi pxf-env.sh
```
Make sure you change `PXF_USER_IMPERSONATION=false`
```
export PXF_USER_IMPERSONATION=false
```
Or you can run this script `disablePXFUserImpersonation.sh` that performs the same operation.

3. Change `/usr/local/greenplum-db/pxf/conf/core-site.xml` to use "quickstart.cloudera".

```
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://quickstart.cloudera:8020</value>
    </property>
</configuration>
```
Or you can run this script `addClouderaToPXFCoreSiteXML.sh` that performs the same operation.

4. Create sample database with the name "pxf_db"
The scripts to create database and sample data is found at `/code/usercase1/pxf/`.

Next, run the command `/code/usecase1/pxf/setupDB.sh`
```
$ /code/usecase1/pxf/setupDB.sh        
GRANT
GRANT
CREATE EXTERNAL TABLE
```

3. Verify database and table is created
Use `psql -U gpadmin -d pxf_db -c "\dE"``
```
[gpadmin@gpdbsne ~]$ psql -U gpadmin -d pxf_db -c "\dE"
                     List of relations
 Schema |        Name         | Type  |  Owner  | Storage  
--------+---------------------+-------+---------+----------
 public | pxf_hdfs_textsimple | table | gpadmin | external
(1 row)

```

## Configure Cloudera
This section describes how to setup Cloudera.

### Setup example data on cloudera
1. You can use this command `docker exec -it quickstart.cloudera bin/bash` to access Cloudera docker instance.
For example:
```
$ docker exec -it quickstart.cloudera bin/bash
[root@quickstart /]#
```
2. This example shows how to use a script to creates sample text file.
```
[root@quickstart cloudera]# /code/usecase1/cloudera/setupHdfsTextSimpleExample.sh
Using root to run this script.
Found hadoop /data directory
Recursively delete files under /data
Deleted /data
## pxf_hdfs_simple.txt is created under this directory /data/pxf_examples/
Found 1 items
-rw-r--r--   1 root supergroup        100 2018-05-07 22:29 /data/pxf_examples/pxf_hdfs_simple.txt
[root@quickstart cloudera]#
```

## Use PSQL to read data via PXF
Make sure you are accessing GPDB docker instance.

1. Use psql on GPDB docker instance
```
$
$ psql -U gpadmin -d pxf_db -c "select * from pxf_hdfs_textsimple;"
location   | month | num_orders | total_sales
-------------+-------+------------+-------------
Prague      | Jan   |        101 |     4875.33
 Rome      | Mar   |         87 |     1557.39
 Bangalore | May   |        317 |     8936.99
 Beijing   | Jul   |        411 |    11600.67
(4 rows)
```

2. Verify the number of records in this table pxf_hdfs_textsimple
```
$ psql -U gpadmin -d pxf_db -c "select count(*) from pxf_hdfs_textsimple;"
count
-------
    4
(1 row)
```
# Links:
- [Greenplum product](https://pivotal.io/pivotal-greenplum)
- [Greenplum documentations](https://https://gpdb.docs.pivotal.io/)


# Howto:
- [How to setup PXF for GPDB 5.x](https://gpdb.docs.pivotal.io/5130/pxf/overview_pxf.html)
- [How to configure User impersonation and Proxy](https://gpdb.docs.pivotal.io/5130/pxf/pxfuserimpers.html)
