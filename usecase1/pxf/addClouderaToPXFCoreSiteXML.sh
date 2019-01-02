#!/bin/bash

set -e

current=`pwd`

cd `dirname $0`

. ./setEnv.sh

if [ -d "/home/gpadmin/pxf" ]
then
  sed -i 's/hdfs:\/\/0.0.0.0:8020/hdfs:\/\/quickstart.cloudera:8020/g' /home/gpadmin/pxf/servers/default/core-site.xml
else
  if [ -d "/usr/local/greenplum-db" ]
  then
    sed -i 's/hdfs:\/\/0.0.0.0:8020/hdfs:\/\/quickstart.cloudera:8020/g' /usr/local/greenplum-db/pxf/servers/default/core-site.xml
  fi
fi


cd $current
