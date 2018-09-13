#!/bin/bash

set -e

current=`pwd`

cd `dirname $0`

. ./setEnv.sh

if [ "$(whoami)" == "gpadmin" ]
then
  # Determine greenplum installation
  if [ -d "/usr/local/gpdb" ] || [ -d "/usr/local/greenplum-db" ]
  then
    psql -h ${GREENPLUM_HOST} -U ${GREENPLUM_USER} -d ${GREENPLUM_DB} -c "select * from pxf_jdbc_postgres_testpxf;"
  else
    echo "Invalid"
  fi
elif [ "$(whoami)" == "root" ]; then
  # Determine greenplum installation
  if [ -d "/usr/local/gpdb" ] || [ -d "/usr/local/greenplum-db" ]
  then
    sudo -u gpadmin -c "psql -h ${GREENPLUM_HOST} -U ${GREENPLUM_USER} -d ${GREENPLUM_DB} -c \"select * from pxf_jdbc_postgres_testpxf;\" "
  else
    echo "Invalid"
  fi
else
  echo "Invalid user"
  exit 1
fi





cd $current
