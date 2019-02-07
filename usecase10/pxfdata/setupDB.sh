#!/bin/bash

set -e

current=`pwd`

cd `dirname $0`

. ./setEnv.sh

if [ "$(whoami)" == "gpadmin" ]
then
  # Determine greenplum installation
  if [ -d "/usr/local/gpdb" ]
  then
    psql -h ${GREENPLUM_HOST} -U ${GREENPLUM_USER} -d ${GREENPLUM_DB} -f ./gpdb_sample.sql
  else
    if [ -d "/usr/local/greenplum-db" ]
    then
      psql -h ${GREENPLUM_HOST} -U ${GREENPLUM_USER} -d ${GREENPLUM_DB} -f ./gpdb_sample.sql
    fi
  fi
elif [ "$(whoami)" == "root" ]; then
  su - gpadmin
  # Determine greenplum installation
  if [ -d "/usr/local/gpdb" ]
  then
    echo "/usr/local/greenplum-db/bin/psql -h ${GREENPLUM_HOST} -U ${GREENPLUM_USER} -d ${GREENPLUM_DB} -f ./gpdb_sample.sql"
    /usr/local/greenplum-db/bin/psql -h ${GREENPLUM_HOST} -U ${GREENPLUM_USER} -d ${GREENPLUM_DB} -f ./gpdb_sample.sql
  else
    if [ -d "/usr/local/greenplum-db" ]
    then
      /usr/local/greenplum-db/bin/psql -h ${GREENPLUM_HOST} -U ${GREENPLUM_USER} -d ${GREENPLUM_DB} -f ./gpdb_sample.sql
    fi
  fi
else
  echo "Invalid user"
  exit 1
fi





cd $current
