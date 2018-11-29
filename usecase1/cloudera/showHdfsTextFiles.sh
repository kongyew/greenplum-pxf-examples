#/bin/bash
#
# hdfs dfs -ls  /data/pxf_examples/

# Enable exit on non 0
# set -e
[[ ${DEBUG} == true ]] && set -x
# set -x

ROOT_UID=0

# Run as root, of course. (this might not be necessary, because we have to run the script somehow with root anyway)
if [ "$UID" -ne "$ROOT_UID" ]
then
    hdfs dfs -ls  /data/pxf_examples/pxf_hdfs_simple.txt
    if [ $? -eq 0 ]
    then
       echo "Found hadoop /data/pxf_examples/pxf_hdfs_simple.txt"
       hdfs dfs -cat /data/pxf_examples/pxf_hdfs_simple.txt
    else
       echo "Not Found  /data/pxf_examples/pxf_hdfs_simple.txt"
    fi

    hdfs dfs -test -f /data/pxf_examples/pxf_hdfs_multi.txt
    if [ $? -eq 0 ]
    then
       echo "Found hadoop /data/pxf_examples/pxf_hdfs_multi.txt"
       hdfs dfs -cat /data/pxf_examples/pxf_hdfs_multi.txt

    else
        echo "Not Found hadoop /data/pxf_examples/pxf_hdfs_multi.txt"
    fi

else
  echo "Running as root"
  hdfs dfs -ls  /data/pxf_examples/pxf_hdfs_simple.txt
  if [ $? -eq 0 ]
  then
     echo "Found hadoop /data/pxf_examples/pxf_hdfs_simple.txt"
     hdfs dfs -cat /data/pxf_examples/pxf_hdfs_simple.txt
  else
     echo "Not Found  /data/pxf_examples/pxf_hdfs_simple.txt"
  fi

  hdfs dfs -test -f /data/pxf_examples/pxf_hdfs_multi.txt
  if [ $? -eq 0 ]
  then
     echo "Found hadoop /data/pxf_examples/pxf_hdfs_multi.txt"
     hdfs dfs -cat /data/pxf_examples/pxf_hdfs_multi.txt

  else
      echo "Not Found hadoop /data/pxf_examples/pxf_hdfs_multi.txt"
  fi


fi
