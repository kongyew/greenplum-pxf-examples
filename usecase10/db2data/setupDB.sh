#!/bin/bash

set -e

current=`pwd`

cd `dirname $0`

. ./setEnv.sh

#!/usr/bin/env bash

# CREATE THE DATABASE
/home/db2inst1/sqllib/bin/db2 create database docker

# Connect to the database
/home/db2inst1/sqllib/bin/db2 connect to DOCKER

# Run all the sql files
echo "Looping thru sqlserver"
for file in ~/sql/*.sql;
do
  echo "$file"
  /home/db2inst1/sqllib/bin/db2 -vtf "$file"
done  >  ~/sql/results.out

cat ~/sql/results.out



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
