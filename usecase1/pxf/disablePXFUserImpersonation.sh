#!/bin/bash

set -e

current=`pwd`

cd `dirname $0`

. ./setEnv.sh

sed -i 's/export PXF_USER_IMPERSONATION=${PXF_USER_IMPERSONATION:=true}/export PXF_USER_IMPERSONATION=false/g' /usr/local/greenplum-db/pxf/conf/pxf-env.sh

cd $current
