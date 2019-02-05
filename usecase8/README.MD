#  Greenplum
The  Greenplum Database (GPDB) is an advanced, fully featured, open source data warehouse. It provides powerful and rapid analytics on petabyte scale data volumes. Uniquely geared toward big data analytics, Greenplum Database is powered by the world’s most advanced cost-based query optimizer delivering high analytical query performance on large data volumes.
<https://www.greenplum.org>

# How to use Greenplum with PXF to access data on Minio
This [repository](https://github.com/kongyew/greenplum-pxf-examples/tree/master/usecase8) demonstrates how to use Greenplum with PXF to read text from Minio.

# Table of Contents
1. [Pre-requisites](#Pre-requisites)
2. [Start Docker-compose](#Start-Docker-compose)
3. [Configure Greenplum](#Configure-Greenplum)
4. [Configure Minio](#Configure-minio)
5. [Use PSQL to read data via PXF](#Use-PSQL-to-read-data-via-PXF)
## Pre-requisites:
- **8GB memory or more** allocated to docker
- [docker-compose](http://docs.docker.com/compose)
- [Minio docker image](https://hub.docker.com/r/minio/minio/)
- [GPDB 5.x docker image](https://hub.docker.com/r/kochanpivotal/gpdb5oss/)

## Start Docker compose
Once you have cloned this repository, you can run the command  `./runDocker.sh -t usecase8 -c up`, in order to start both Greenplum and Minio docker instances.

The assumption: docker and docker-compose are already installed on your machine.

### Run command to start both Greenplum and Minio instances
```
$ ./runDocker.sh -t usecase8 -c up
Creating gpdbsne     ... done
Creating minio2  ... done
Creating minio1  ... done
Creating minio3  ... done
Creating minio4  ... done
Creating minioclient ... done

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
2. Following this instruction on [how to create Minio configuration file](https://gpdb.docs.pivotal.io/latest/pxf/objstore_cfg.html)

First, you can use existing template for minio configuration file such as minio-site.xml
```
[gpadmin@gpdbsne pxf]$ ls -al /home/gpadmin/pxf/templates
total 52
drwxr-xr-x 2 gpadmin gpadmin 4096 Jan 30 00:09 .
drwxrwxr-x 1 gpadmin gpadmin 4096 Jan 30 00:09 ..
-rw-r--r-- 1 gpadmin gpadmin  573 Jan 30 00:09 adl-site.xml
-rw-r--r-- 1 gpadmin gpadmin  180 Jan 30 00:09 core-site.xml
-rw-r--r-- 1 gpadmin gpadmin  494 Jan 30 00:09 gs-site.xml
-rw-r--r-- 1 gpadmin gpadmin  295 Jan 30 00:09 hbase-site.xml
-rw-r--r-- 1 gpadmin gpadmin  712 Jan 30 00:09 hdfs-site.xml
-rw-r--r-- 1 gpadmin gpadmin  191 Jan 30 00:09 hive-site.xml
-rw-r--r-- 1 gpadmin gpadmin  310 Jan 30 00:09 mapred-site.xml
-rw-r--r-- 1 gpadmin gpadmin  617 Jan 30 00:09 minio-site.xml
-rw-r--r-- 1 gpadmin gpadmin  407 Jan 30 00:09 s3-site.xml
-rw-r--r-- 1 gpadmin gpadmin  539 Jan 30 00:09 wasbs-site.xml
-rw-r--r-- 1 gpadmin gpadmin  189 Jan 30 00:09 yarn-site.xml
```

Second, create a unique folder under $PXF_CONF/servers folder, so we can create minio specific configuration file. For example, you can create `minioserver` server folder under `$PXF_CONF/servers`
```
[gpadmin@gpdbsne pxf]$ mkdir /home/gpadmin/pxf/servers/minioserver
```

Next, you can copy `minio-site.xml` file to the pre-created folder
```
[gpadmin@gpdbsne pxf]$ cp  /home/gpadmin/pxf/templates/minio-site.xml /home/gpadmin/pxf/servers/minioserver/
```

You can configure the settings in the `minio-site.xml` by using the configuration below.
```
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
    <property>
        <name>fs.s3a.endpoint</name>
        <value>http://minio1:9000</value>
    </property>
    <property>
        <name>fs.s3a.access.key</name>
        <value>minio</value>
    </property>
    <property>
        <name>fs.s3a.secret.key</name>
        <value>minio123</value>
    </property>
    <property>
        <name>fs.s3a.fast.upload</name>
        <value>true</value>
    </property>
    <property>
        <name>fs.s3a.path.style.access</name>
        <value>true</value>
    </property>
</configuration>
```


Alternatively, you can run this script that creates minioserver folder and create minio-site.xml
```
[root@gpdbsne /]# cd /code/usecase8/pxf/conf
[root@gpdbsne conf]# ./setupMinioConfig.sh 
Found folder /home/gpadmin/pxf/servers
mkdir: cannot create directory '/home/gpadmin/pxf/servers/minioserver': File exists
cp ./minio-core-site.xml /home/gpadmin/pxf/servers/minioserver
Stopping PXF service
seghostfile Found
[WARN] Reference default values as $MASTER_DATA_DIRECTORY/gpssh.conf could not be found
Using delaybeforesend 0.05 and prompt_validation_timeout 60.0

[Reset ...]

...

```

3. Restart PXF daemons so PXF loads the new configuration (minio-site.xml) 

```
[gpadmin@gpdbsne pxf]$ cd /usr/local/greenplum-db/pxf/bin
[gpadmin@gpdbsne bin]$ pxf stop
Using CATALINA_BASE:   /usr/local/greenplum-db/pxf/pxf-service
Using CATALINA_HOME:   /usr/local/greenplum-db/pxf/pxf-service
Using CATALINA_TMPDIR: /usr/local/greenplum-db/pxf/pxf-service/temp
Using JRE_HOME:        /usr/lib/jvm/jre-openjdk/
Using CLASSPATH:       /usr/local/greenplum-db/pxf/pxf-service/bin/bootstrap.jar:/usr/local/greenplum-db/pxf/pxf-service/bin/tomcat-juli.jar
Using CATALINA_PID:    /usr/local/greenplum-db/pxf/run/catalina.pid
Tomcat stopped.
[gpadmin@gpdbsne bin]$ pxf start
Using CATALINA_BASE:   /usr/local/greenplum-db/pxf/pxf-service
Using CATALINA_HOME:   /usr/local/greenplum-db/pxf/pxf-service
Using CATALINA_TMPDIR: /usr/local/greenplum-db/pxf/pxf-service/temp
Using JRE_HOME:        /usr/lib/jvm/jre-openjdk/
Using CLASSPATH:       /usr/local/greenplum-db/pxf/pxf-service/bin/bootstrap.jar:/usr/local/greenplum-db/pxf/pxf-service/bin/tomcat-juli.jar
Using CATALINA_PID:    /usr/local/greenplum-db/pxf/run/catalina.pid
Tomcat started.
Checking if tomcat is up and running...
tomcat not responding, re-trying after 1 second (attempt number 1)
Server: Apache-Coyote/1.1
Checking if PXF webapp is up and running...
PXF webapp is listening on port 5888
[gpadmin@gpdbsne bin]$ 
```

4. Create sample database with the name "pxf_db"
The scripts to create database and sample data is found at `/code/usercase8/pxf/`.

Next, run the command `/code/usecase8/pxf/setupDB.sh`
```
[gpadmin@gpdbsne pxf]$ ./setupDB.sh 
CREATE EXTENSION
GRANT
GRANT
CREATE EXTERNAL TABLE
CREATE EXTERNAL TABLE
CREATE EXTERNAL TABLE
```

3. Verify database and table is created
Use `psql -U gpadmin -d pxf_db -c "\dE"``
```
[gpadmin@gpdbsne pxf]$ psql -U gpadmin -d pxf_db -c "\dE"
                       List of relations
 Schema |           Name           | Type  |  Owner  | Storage  
--------+--------------------------+-------+---------+----------
 public | pxf_minio_stocks         | table | gpadmin | external
 public | pxf_minio_stocks_json    | table | gpadmin | external
 public | pxf_minio_stocks_parquet | table | gpadmin | external
(3 rows)
[gpadmin@gpdbsne pxf]$ 
```

## Configure Minio
This section describes how to access Minio

1. You can use this command `docker exec -it docker exec -it minio1 bin/sh` to access Minio docker instance.
For example:
```
$ docker exec -it  minio1 bin/sh
[root@quickstart /]#
```
2. This example shows how to download minio client and use it
```
[root@root]# wget https://dl.minio.io/client/mc/release/linux-amd64/mc
[root@root]# chmod +x mc

[root@root]# ./mc --help
```

## Use mc to access minio1:9000

```
/ # ./mc ls minio/testbucket
[2019-02-05 17:42:21 UTC] 1.7KiB read_stocks.sql
[2019-02-05 17:42:20 UTC]  12KiB stocks.csv
[2019-02-05 17:42:20 UTC]   138B testdata.csv
[2019-02-05 19:40:15 UTC]     0B stocks_parquet.csv/
```



# Links:
- [Greenplum PXF](https://gpdb.docs.pivotal.io/latest/pxf/overview_pxf.html)
- [Greenplum product](https://pivotal.io/pivotal-greenplum)
- [Greenplum documentations](https://https://gpdb.docs.pivotal.io/)
- [Minio for Greenplum](https://network.pivotal.io/products/minio-greenplum)

# Howto:
- [How to setup PXF for GPDB 5.x](https://gpdb.docs.pivotal.io/latest/pxf/overview_pxf.html)
- [How to configure PXF to access Object storage](https://gpdb.docs.pivotal.io/5160/pxf/objstore_cfg.html)
- [How to configure User impersonation and Proxy](https://gpdb.docs.pivotal.io/latest/pxf/pxfuserimpers.html)
