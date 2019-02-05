#!/bin/bash

export MINIO_SITE_XML="./minio-core-site.xml"
export PXF_SERVERS="/home/gpadmin/pxf/servers"

export START_PXF="/usr/local/bin/startPXF.sh"
export STOP_PXF="/usr/local/bin/stopPXF.sh"

if [ -d $PXF_SERVERS ] # check directory
then
   echo "Found folder $PXF_SERVERS"
   mkdir $PXF_SERVERS/minioserver
else
   echo "folder $PXF_SERVERS is not found"
 # TBD
fi

if [ -f $MINIO_SITE_XML ]
then
   echo "cp $MINIO_SITE_XML $PXF_SERVERS/minioserver"
    cp $MINIO_SITE_XML $PXF_SERVERS/minioserver/minio-core-site.xml
else
   echo "$MINIO_SITE_XML is not found"
 # TBD
fi

# cat /home/gpadmin/pxf/servers/minioserver/minio-core-site.xml 

echo "Stopping PXF service"
$STOP_PXF
echo "Starting PXF service"
$START_PXF
