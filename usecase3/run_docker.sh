#!/bin/bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Including configurations
. "${DIR}"/config.sh


docker run --restart on-failure -p 5432:5432 -d --name kochanpivotal/gpdb5-pxf
# The default username and password are "admin" and "admin".
