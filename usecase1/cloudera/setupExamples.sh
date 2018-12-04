#/bin/bash
[[ ${DEBUG} == true ]] && set -x
set -x
ROOT_UID=0

current=`pwd`

cd `dirname $0`

. ./config.sh

# Run as root, of course. (this might not be necessary, because we have to run the script somehow with root anyway)
if [ "$UID" -ne "$ROOT_UID" ]
then
  ./setupgpadmin.sh
  ./setupHdfsTextSimpleExample.sh
  ./setupHdfsJsonFiles.sh
else
  echo "Running as root"
  ./setupgpadmin.sh
  ./setupHdfsTextSimpleExample.sh
  ./setupHdfsJsonFiles.sh
fi
cd $current
