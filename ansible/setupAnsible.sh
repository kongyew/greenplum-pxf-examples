#!/usr/bin/env bash
rm -rf /opt/ansible/
rm -rf /opt/ansible/ansible
rm -rf /etc/ansible/
yum clean all && \
    yum -y install epel-release && \
    yum -y install PyYAML python-jinja2 python-httplib2 python-keyczar python-paramiko python-setuptools git python-pip

mkdir /etc/ansible/
echo '[local]\nlocalhost\n' > /etc/ansible/hosts
mkdir /opt/ansible/
git clone http://github.com/ansible/ansible.git /opt/ansible/ansible
cd /opt/ansible/ansible
git submodule update --init

export PATH=$PATH:/opt/ansible/ansible/bin:/bin:/usr/bin:/sbin:/usr/sbin
export PYTHONPATH=$PYTHONPATH:/opt/ansible/ansible/lib
export ANSIBLE_LIBRARY=$ANSIBLE_LIBRARY:/opt/ansible/ansible/library
