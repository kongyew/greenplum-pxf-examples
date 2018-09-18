#!/bin/bash

set -e

current=`pwd`

cd `dirname $0`

. ./setEnv.sh





if [ "$(whoami)" == "postgres" ]
then
  $status=`which psql`
  if [ $? == 0 ]; then
      psql -h ${POSTGRES_HOST} -U ${POSTGRES_USER} -d ${POSTGRES_DB} -f ./sample.sql
  fi

elif [ "$(whoami)" == "root" ]; then
  #sudo -u postgres createdb -h ${POSTGRES_HOST} -U ${POSTGRES_USER}  ${POSTGRES_DB}
  sudo -u postgres psql -h ${POSTGRES_HOST} -U ${POSTGRES_USER} -d ${POSTGRES_DB} -f ./sample.sql

else
  echo "Invalid user"
  exit 1
fi


cd $current
