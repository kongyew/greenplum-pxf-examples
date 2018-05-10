#
#
# User: gpadmin Password: pivotal
# or root/pivotal
# How to build this image via CLI
# $ docker build -t gpdb-spark -f ./Dockerfile  .


FROM pivotaldata/gpdb-base
LABEL name="gpdb-spark"
LABEL description="Example for Greenplum with Spark - test"
LABEL version=1.1.1
#Use root
USER root
# Install JDK
ENV JAVA_VERSION 8u31
ENV BUILD_VERSION b13

# fix this issue : Rpmdb checksum is invalid: dCDPT(pkg checksums)
RUN rpm --rebuilddb; yum install -y yum-plugin-ovl

# Upgrading system
RUN yum -y upgrade
RUN yum -y install wget
#RUN yum -y install unzip


# Install psql, createDB
RUN yum install -y postgresql


ENV JAVA_VERSION 1.8.0
RUN yum -y update && yum install -y java-"${JAVA_VERSION}"-openjdk && yum clean all
ENV JAVA_HOME /usr/java/latest



## Install Kerberos5 client
RUN	yum install -y -q krb5-libs krb5-workstation

# Default ports:
# GPDB 5432
# SEGMENT 40000
EXPOSE 9090:9090 5432 5005 5010 9022:22 40000 40001 40002
VOLUME ["/gpdata/"]

# Define default command.
