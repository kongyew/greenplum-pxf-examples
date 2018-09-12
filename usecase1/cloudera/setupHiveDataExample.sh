#/bin/bash
#!/bin/bash
set -e
[[ ${DEBUG} == true ]] && set -x


ROOT_UID=0
export OUTPUTFILE=pxf_hive_datafile.txt
export HADOOP_USER_NAME=hdfs hive
# Run as root, of course. (this might not be necessary, because we have to run the script somehow with root anyway)
if [ "$UID" -ne "$ROOT_UID" ]
then
  echo "Using $UID to run this script."

  if [ -f /data/pxf_examples/$OUTPUTFILE ]
  then
    rm /tmp/$OUTPUTFILE
  fi


  chown -R gpadmin:gpadmin /tmp/$OUTPUTFILE
  sudo -u hdfs hadoop fs -mkdir -p /data/pxf_examples
  sudo -u hdfs hadoop fs -put /tmp/$OUTPUTFILE /data/pxf_examples/

else
  echo "Using root to run this script."

  if [ -f /data/pxf_examples/$OUTPUTFILE ]
  then
    rm /tmp/$OUTPUTFILE
  fi

  echo -e Prague,Jan,101,4875.33 > /tmp/$OUTPUTFILE
  echo  -e "Prague,Jan,101,4875.33" >> /tmp/$OUTPUTFILE
  echo  -e "Rome,Mar,87,1557.39" >> /tmp/$OUTPUTFILE
  echo  -e "Bangalore,May,317,8936.99" >> /tmp/$OUTPUTFILE
  echo  -e "Beijing,Jul,411,11600.67" >> /tmp/$OUTPUTFILE
  echo  -e "San Francisco,Sept,156,6846.34" >> /tmp/$OUTPUTFILE
  echo  -e "Prague,Dec,333,9894.77" >> /tmp/$OUTPUTFILE
  echo  -e "Bangalore,Jul,271,8320.55" >> /tmp/$OUTPUTFILE
  echo  -e "Beijing,Dec,100,4248.41" >> /tmp/$OUTPUTFILE
fi

echo "### DROP TABLE IF EXISTS sales_info; "
beeline -u jdbc:hive2://localhost:10000/default -n scott -p tiger -e "DROP TABLE IF EXISTS sales_info;"

echo "### CREATE TABLE sales_info "
beeline -u jdbc:hive2://localhost:10000/default -n scott -p tiger -e "CREATE TABLE sales_info (location string, month string,
        number_of_orders int, total_sales double)
        ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
         STORED AS textfile; "

echo "### Upload data into sales_info; "
beeline -u jdbc:hive2://localhost:10000/default -n scott -p tiger -e "LOAD DATA LOCAL INPATH '/tmp/pxf_hive_datafile.txt'
        INTO TABLE sales_info;"

echo "### List tables "
beeline -u jdbc:hive2://localhost:10000/default -n scott -p tiger -e "show tables"

echo "### select * from sales_info "
beeline -u jdbc:hive2://localhost:10000/default -n scott -p tiger -e "select * from sales_info"
