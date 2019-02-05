#!/bin/bash
#
#
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export DOCKER_OSS_LABEL="GPDB 5 OSS"
export DOCKER_OSS_TAG="kochanpivotal/gpdb5-pxf"
export DOCKER_LATEST_OSS_TAG="kochanpivotal/gpdb5-pxf:latest"

# Use Cases specific
export DC_USE_CASE1_SCRIPT="docker-compose -f ./usecase1/docker-compose.yml"
export DC_USE_CASE2_SCRIPT="docker-compose -f ./usecase2/docker-compose-postgres9.6.yml"
export DC_USE_CASE3_SCRIPT="docker-compose -f ./usecase3/docker-compose.yml"
export DC_USE_CASE4_SCRIPT="docker-compose -f ./usecase4/docker-compose.yml"
export DC_USE_CASE5_SCRIPT="docker-compose -f ./usecase5/docker-compose.yml"
export DC_USE_CASE6_SCRIPT="docker-compose -f ./usecase6/docker-compose.yml"
export DC_USE_CASE7_SCRIPT="docker-compose -f ./usecase7/docker-compose.yml"
export DC_USE_CASE8_SCRIPT="docker-compose -f ./usecase8/docker-compose.yml"
