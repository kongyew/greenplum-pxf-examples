#/bin/bash
#
# hdfs dfs -ls  /data/pxf_examples/

# Enable exit on non 0
# set -e


[[ ${DEBUG} == true ]] && set -x
set -x
ROOT_UID=0

# Run as root, of course. (this might not be necessary, because we have to run the script somehow with root anyway)
if [ "$UID" -ne "$ROOT_UID" ]
then

  hdfs dfs -test -d /data
  if [ $? -eq 0 ]
  then
     echo "Found hadoop /data directory"
  else
    sudo -u hdfs hadoop fs -mkdir -p /data
    hdfs dfs -test -d /data/pxf_examples
    if [ $? -eq 0 ]
    then
       echo "Found hadoop /data/pxf_examples directory"
    else

      sudo -u hdfs hadoop fs -mkdir -p /data/pxf_examples
    fi
  fi


    hdfs dfs -ls  /data/pxf_examples/singleline.json
    if [ $? -eq 0 ]
    then
       echo "Found hadoop /data/pxf_examples/singleline.json"
    else
       echo "test"
      sudo -u hdfs  dfs -put ./JSON/singleline.json /data/pxf_examples/
    fi

    hdfs dfs -test -f /data/pxf_examples/multiline.json
    if [ $? -eq 0 ]
    then
       echo "Found hadoop /data/pxf_examples/multiline.json"
    else
       sudo -u hdfs dfs -put ./JSON/multiline.json /data/pxf_examples/
    fi

else
  echo "Running as root"
  hdfs dfs -test -d /data
  if [ $? -eq 0 ]
  then
     echo "Found hadoop /data directory"
  else
    sudo -u hdfs hadoop fs -mkdir -p /data
    hdfs dfs -test -d /data/pxf_examples
    if [ $? -eq 0 ]
    then
       echo "Found hadoop /data/pxf_examples directory"
    else
       hdfs hadoop fs -mkdir -p /data/pxf_examples
    fi
  fi

  #hdfs dfs -ls /data/pxf_examples/

  hdfs dfs -ls  /data/pxf_examples/singleline.json
  if [ $? -eq 0 ]
  then
     echo "Found hadoop /data/pxf_examples/singleline.json"
  else
     echo "test"
     hdfs  dfs -put ./JSON/singleline.json /data/pxf_examples/
  fi

  hdfs dfs -test -f /data/pxf_examples/multiline.json
  if [ $? -eq 0 ]
  then
     echo "Found hadoop /data/pxf_examples/multiline.json"
  else
     hdfs dfs -put ./JSON/multiline.json /data/pxf_examples/
  fi

fi
