# Readme
This documentation describes how to access external SQL databases with JDBC.

Greenplum provides capability to read data from external databases including Postgresql, MySQL, Oracle and others.

# Table of Contents
1. [Pre-requisites](#Pre-requisites)
2. [Run this example](#Run-this-example)
3. [Configure Greenplum](#Configure-Greenplum)
4. [Configure Postgresql](#Configure-Postgresql)

## Pre-requisites:
- [docker-compose](http://docs.docker.com/compose)
- [GPDB 5.x docker image](https://hub.docker.com/r/kochanpivotal/gpdb5-pxf/)

## Run this example
You can use this script 'runDocker.sh' to run these use Cases

For example, you can use this example `./runDocker.sh -t usecase2 -c up`
```
$ ./runDocker.sh -t usecase2 -c up
Creating gpdbsne ... done
Creating postgresql ... done
Attaching to gpdbsne, postgresql
gpdbsne     | /etc/sysconfig/run-parts
gpdbsne     | /usr/bin/run-parts
...
gpdbsne     | + echo 'SSHD is running...'
gpdbsne     | SSHD is running...
gpdbsne     | Running bin/bash
postgresql  | 2018-05-08 23:27:45 UTC LOG:  database system was shut down at 2018-05-08 23:27:45 UTC
postgresql  | 2018-05-08 23:27:45 UTC LOG:  autovacuum launcher started
postgresql  | 2018-05-08 23:27:45 UTC LOG:  database system is ready to accept connections

```

## Configure Greenplum
1. You can access this Greenplum docker instance
```
$ docker exec -it gpdbsne bin/bash
[root@gpdbsne /]#
[root@gpdbsne /]#
```
2. Next, you can run GPDB by using this command `startGPDB.sh`
```
[root@gpdbsne /]# startGPDB.sh
SSHD is running
SSHD is running...
20180508:23:38:58:000150 gpstart:gpdbsne:gpadmin-[INFO]:-Starting gpstart with args: -a
20180508:23:38:58:000150 gpstart:gpdbsne:gpadmin-[INFO]:-Gathering information and validating the environment...
...
20180508:23:39:11:000370 gpstart:gpdbsne:gpadmin-[ERROR]:-gpstart error: Master instance process running
[root@gpdbsne /]#
```
3. You can use gpadmin account to create sample database and table.
The following example uses setupDB.sh under `/code/usecase2/PXFExamples/`.
```
# su - gpadmin
Last login: Tue May  8 23:39:11 UTC 2018 on pts/1
[gpadmin@gpdbsne ~]$ cd /code/usecase2/PXFExamples/
[gpadmin@gpdbsne PXFExamples]$ ./setupDB.sh
CREATE EXTENSION
GRANT
GRANT
psql:./gpdb_sample.sql:5: NOTICE:  table "pxf_jdbc_postgres_table1" does not exist, skipping
DROP EXTERNAL TABLE
CREATE EXTERNAL TABLE
psql:./gpdb_sample.sql:13: NOTICE:  table "pxf_jdbc_postgres_testpxf" does not exist, skipping
DROP EXTERNAL TABLE
CREATE EXTERNAL TABLE
[gpadmin@gpdbsne PXFExamples]$
```


## Configure Postgresql
1. You can access this Postgresql docker instance
```
$ docker exec -it postgresql bin/bash
root@postgresql:/#
```

2. Next, you can use postgres user by using `su postgres`.

This example shows how to use psql to login to the `postgres` database.
```
root@postgresql:/# su postgres
postgres@postgresql:/$ psql -d postgres
Welcome to psql 8.3.23, the PostgreSQL interactive terminal.

Type:  \copyright for distribution terms
       \h for help with SQL commands
       \? for help with psql commands
       \g or terminate with semicolon to execute query
       \q to quit

postgres=#
```



# Reference:
[Greenplum - PXF](https://gpdb.docs.pivotal.io/570/pxf/using_pxf.html)

## Pivotal Greenplum
The Pivotal Greenplum Database (GPDB) is an advanced, fully featured, open source data warehouse. It provides powerful and rapid analytics on petabyte scale data volumes. Uniquely geared toward big data analytics, Greenplum Database is powered by the world’s most advanced cost-based query optimizer delivering high analytical query performance on large data volumes.
<https://pivotal.io/pivotal-greenplum>
