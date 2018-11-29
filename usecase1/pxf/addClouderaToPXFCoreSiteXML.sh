#!/bin/bash

set -e

current=`pwd`

cd `dirname $0`

. ./setEnv.sh

sed -i 's/hdfs:\/\/0.0.0.0:8020/hdfs:\/\/quickstart.cloudera:8020/g' /usr/local/greenplum-db/pxf/conf/core-site.xml

cd $current
