#! /bin/bash

set -eux
set -o xtrace

echo "### INSTALL PACKAGES"

yum update -y
yum install -y amazon-efs-utils aws-cli

echo "### INSTALL SSM AGENT"

cd /tmp
yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
restart amazon-ssm-agent

echo "### SETUP AGENT"

/etc/eks/bootstrap.sh ${tf_cluster_name}

echo "### EXTRA USERDATA"

${userdata_extra}
