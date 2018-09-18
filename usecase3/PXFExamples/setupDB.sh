#!/bin/bash

set -e

current=`pwd`

cd `dirname $0`

. ./setEnv.sh



ROOT_UID=0


if [ "$UID" -eq "postgres" ]
then
  $status=`which psql`
  # Determine greenplum installation
  if [ $? eq 0 ]
    psql -h ${POSTGRES_HOST} -U ${POSTGRES_USER} -d ${POSTGRES_DB} -f ./sample.sql
  fi
elif [ "$UID" -eq "$ROOT_UID" ]; then
then
  su - postgres
  $status=`which psql`
  # Determine greenplum installation
  if [ $? eq 0 ]
    psql -h ${POSTGRES_HOST} -U ${POSTGRES_USER} -d ${POSTGRES_DB} -f ./sample.sql
  fi


else
  echo "Invalid user"
  exit 1
fi


cd $current
