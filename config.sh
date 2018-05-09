#!/bin/bash
#
#
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export DOCKER_OSS_LABEL="GPDB 5 OSS"
export DOCKER_OSS_TAG="kochanpivotal/gpdb5-pxf"
export DOCKER_LATEST_OSS_TAG="kochanpivotal/gpdb5-pxf:latest"

# Use Cases specific
export DC_USE_CASE1_SCRIPT="docker-compose -f ./usecase1/docker-compose-cloudera.yml"
export DC_USE_CASE2_SCRIPT="docker-compose -f ./usecase2/docker-compose-postgres8.3.yml"
