#!/bin/bash
#
#
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export GPDB_HOSTS=/tmp/gpdb-hosts

echo "export PXF_HOME=/usr/local/greenplum-db/pxf
echo "export PATH=$PATH:$PXF_HOME/bin"
