#!/bin/bash -x
echo "Downloading JDBC for DB2 version 11.1"
curl -o db2jcc.jar https://www-01.ibm.com/support/docview.wss?uid=swg21385217

PWD=`pwd`
JDBC_JAR=$(ls $PWD/db2jcc.jar)
PXFPUBLIC_FILE="/usr/local/greenplum-db/pxf/conf/pxf-public.classpath"



if [ -d "/usr/local/gpdb" ]
then
  echo "Found /usr/local/gpdb"
else
  if [ -d "/usr/local/greenplum-db" ]
  then
    echo "Found /usr/local/greenplum-db"
    cp $JDBC_JAR /usr/local/greenplum-db/pxf/lib/
  else
    echo " /usr/local/greenplum-db directory does NOT exists"

  fi
fi
