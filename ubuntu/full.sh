# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
# 
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#!/bin/bash -x
apt-get update
apt-get install -y wget vim curl screen git software-properties-common python-software-properties
add-apt-repository -y ppa:webupd8team/java
apt-get update
/bin/echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
apt-get -y install oracle-java7-installer oracle-java7-set-default

wget http://public-repo-1.hortonworks.com/HDP/ubuntu12/2.x/hdp.list -O /etc/apt/sources.list.d/hdp.list  
apt-get update

#HDP install
apt-get install -y --force-yes --allow-unauthenticated hadoop hadoop-hdfs libhdfs0 libhdfs0-dev hadoop-yarn hadoop-mapreduce hadoop-client openssl
#compression libraries
apt-get install -y --force-yes --allow-unauthenticated libsnappy1 libsnappy-dev
apt-get install -y --force-yes --allow-unauthenticated liblzo2-2 liblzo2-dev hadoop-lzo

echo "172.16.45.5 localhost hdpck" > /etc/hosts

#some more prep for HDP
hdp_config_dir=/vagrant/vagrant/hdp_manual_install_rpm_helper_files-2.0.6.76
. $hdp_config_dir/env.sh

echo "hdp_config_dir=/vagrant/vagrant/hdp_manual_install_rpm_helper_files-2.0.6.76" >> ~/.bashrc
echo ". $hdp_config_dir/env.sh" >> ~/.bashrc

mkdir -p $DFS_NAME_DIR;
chown -R $HDFS_USER:$HADOOP_GROUP $DFS_NAME_DIR;
chmod -R 755 $DFS_NAME_DIR;

mkdir -p $YARN_LOCAL_LOG_DIR;
chown -R $YARN_USER:$HADOOP_GROUP $YARN_LOCAL_LOG_DIR;
chmod -R 755 $YARN_LOCAL_LOG_DIR;

mkdir -p $FS_CHECKPOINT_DIR;
chown -R $HDFS_USER:$HADOOP_GROUP $FS_CHECKPOINT_DIR;
chmod -R 755 $FS_CHECKPOINT_DIR;

mkdir -p $DFS_DATA_DIR;
chown -R $HDFS_USER:$HADOOP_GROUP $DFS_DATA_DIR;
chmod -R 750 $DFS_DATA_DIR;

mkdir -p $YARN_LOCAL_DIR;
chown -R $YARN_USER:$HADOOP_GROUP $YARN_LOCAL_DIR;
chmod -R 755 $YARN_LOCAL_DIR;

mkdir -p $YARN_LOCAL_LOG_DIR;
chown -R $YARN_USER:$HADOOP_GROUP $YARN_LOCAL_LOG_DIR;
chmod -R 755 $YARN_LOCAL_LOG_DIR;

mkdir -p $HDFS_LOG_DIR;
chown -R $HDFS_USER:$HADOOP_GROUP $HDFS_LOG_DIR;
chmod -R 755 $HDFS_LOG_DIR;

mkdir -p $YARN_LOG_DIR;
chown -R $YARN_USER:$HADOOP_GROUP $YARN_LOG_DIR;
chmod -R 755 $YARN_LOG_DIR;

mkdir -p $HDFS_PID_DIR;
chown -R $HDFS_USER:$HADOOP_GROUP $HDFS_PID_DIR;
chmod -R 755 $HDFS_PID_DIR

mkdir -p $YARN_PID_DIR;
chown -R $YARN_USER:$HADOOP_GROUP $YARN_PID_DIR;
chmod -R 755 $YARN_PID_DIR;

mkdir -p $MAPRED_LOG_DIR;
chown -R $MAPRED_USER:$HADOOP_GROUP $MAPRED_LOG_DIR;
chmod -R 755 $MAPRED_LOG_DIR;

mkdir -p $MAPRED_PID_DIR;
chown -R $MAPRED_USER:$HADOOP_GROUP $MAPRED_PID_DIR;
chmod -R 755 $MAPRED_PID_DIR;

cp -f $hdp_config_dir/configuration_files/core_hadoop/hdfs-site.xml /etc/hadoop/conf/
cp -f $hdp_config_dir/configuration_files/core_hadoop/core-site.xml /etc/hadoop/conf/

cd /usr/lib/hadoop-hdfs/
ln -s /usr/lib/hadoop/libexec libexec

mkdir /usr/lib/hadoop/logs
chmod a+rw /usr/lib/hadoop/logs

mkdir /usr/lib/hadoop/hdfsnamedir
chmod a+rw /usr/lib/hadoop/hdfsnamedir
chown -R $HDFS_USER:$HADOOP_GROUP /usr/lib/hadoop/hdfsnamedir

#lets getter runnin
#/usr/lib/hadoop-hdfs/bin/hdfs namenode -format
#/usr/lib/hadoop/sbin/hadoop-daemon.sh --config $HADOOP_CONF_DIR start namenode

