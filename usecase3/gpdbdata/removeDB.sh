#!/bin/bash


set -e

current=`pwd`

cd `dirname $0`

. ./setEnv.sh

cd $current

echo "psql -h ${POSTGRES_HOST} -U ${POSTGRES_USER} -d postgres -c \"DROP TABLE IF EXISTS sampletable1\" "
psql -h ${POSTGRES_HOST} -U ${POSTGRES_USER} -d postgres -c "DROP TABLE IF EXISTS sampletable1"

echo "psql -h ${POSTGRES_HOST} -U ${POSTGRES_USER} -d postgres -c \"DROP TABLE IF EXISTS sampletable2\" "
psql -h ${POSTGRES_HOST} -U ${POSTGRES_USER} -d postgres -c "DROP TABLE IF EXISTS sampletable2"

echo "psql -h ${POSTGRES_HOST} -U ${POSTGRES_USER} -d postgres -c \"DROP DATABASE ${POSTGRES_DB}\" "
psql -h ${POSTGRES_HOST} -U ${POSTGRES_USER} -d postgres -c "DROP DATABASE  ${POSTGRES_DB}"
