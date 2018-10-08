#!/bin/bash

mkdir -p /data/$HOSTNAME

gfsh start server --name=$HOSTNAME --locators=locator[10334] --locator-wait-time=30 --log-level=ALL  \
--start-rest-api=true --dir=/data/$HOSTNAME/ "$@"

while true; do
    sleep 30
  done
done
