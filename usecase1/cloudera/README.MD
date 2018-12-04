# This folder contains scripts and data for Cloudera

## setupExamples.sh
This script creates all examples including text, json and other examples.

## setupgpadmin.sh
This script creates user (gpadmin)

You can use this sed command to disable user impersonation

s/export PXF_USER_IMPERSONATION=${PXF_USER_IMPERSONATION:=true}/export PXF_USER_IMPERSONATION=false/g' /usr/local/greenplum-db/pxf/conf/pxf-env.sh
