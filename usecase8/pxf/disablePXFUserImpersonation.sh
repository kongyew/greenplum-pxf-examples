#!/bin/bash

set -e

current=`pwd`

cd `dirname $0`

. ./setEnv.sh




if [ -d "/home/gpadmin/pxf" ]
then
  sed -i 's/export PXF_USER_IMPERSONATION=${PXF_USER_IMPERSONATION:=true}/export PXF_USER_IMPERSONATION=false/g' /home/gpadmin/pxf/conf/pxf-env.sh
else
  if [ -d "/usr/local/greenplum-db" ]
  then
    sed -i 's/export PXF_USER_IMPERSONATION=${PXF_USER_IMPERSONATION:=true}/export PXF_USER_IMPERSONATION=false/g' /usr/local/greenplum-db/pxf/conf/pxf-env.sh
  fi
fi


cd $current
