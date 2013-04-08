#!/bin/bash

downloadType="wget"
base_dir=/usr/local/tmp/cloud

## HADOOP INSTALL ##
hadoop_version="1.1.2"
hadoop_file_name="hadoop-$hadoop_version"
hadoop_download="$hadoop_file_name.tar.gz"
hadoop_mirror="http://apache.petsads.us/hadoop/common"
hadoop_download_uri="$hadoop_mirror/$hadoop_file_name/$hadoop_download"
#http://apache.petsads.us/hadoop/common/hadoop-<version>/<file>
#http://www.poolsaboveground.com/apache/hadoop/common/hadoop-<version>/<file>
#http://mirror.cc.columbia.edu/pub/software/apache/hadoop/common/hadoop-<version>/<file>

echo "starting cloud installation..."

echo "creating directories"

mkdir -p $base_dir/hadoop
mkdir -p $base_dir/hadoop/hdfs
mkdir -p $base_dir/zookeeper
mkdir -p $base_dir/accumulo

echo "directories created"


cd $base_dir/hadoop

#echo "downloading hadoop version $hadoop_version from $hadoop_mirror"
#$downloadType $hadoop_download_uri  
#echo "downloaded hadoop artifact"

tar -xvf $hadoop_download

ln -s $hadoop_file_name current

d=$(pwd)
echo "current directory $d"

java_home=$(echo $JAVA_HOME)

echo "setting JAVA_HOME in $base_dir/hadoop/current/conf/hadoop-env-back.sh -> $java_home"

d=$(pwd)
echo "current directory $d"
sed -i .bak '/export JAVA_HOME/a \
export JAVA_HOME='"$(echo $JAVA_HOME)" $base_dir/hadoop/current/conf/hadoop-env.sh

cat <<EOF > $base_dir/hadoop/current/conf/core-site.xml
<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>

<!-- Put site-specific property overrides in this file. -->

<configuration>
    <property>
	<name>fs.default.name</name>
	<value>hdfs://localhost:9000</value>
    </property>
</configuration>
EOF



cat <<EOF > $base_dir/hadoop/current/conf/hdfs-site.xml
<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>

<!-- Put site-specific property overrides in this file. -->

<configuration>
	<property>
		<name>dfs.data.dir</name>
		<value>$base_dir/hadoop/hdfs/data</value>
	</property>
	<property>
		<name>dfs.name.dir</name>
		<value>$base_dir/hadoop/hdfs/name</value>
	</property>
	<property>
		<name>dfs.replication</name>
		<value>1</value>
	</property>
</configuration>
EOF


cat <<EOF > $base_dir/hadoop/current/conf/mapred-site.xml
<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>

<!-- Put site-specific property overrides in this file. -->

<configuration>
	<property>
		<name>mapred.job.tracker</name>
		<value>localhost:9001</value>
	</property>
</configuration>
EOF




$base_dir/hadoop/current/bin/hadoop namenode -format

echo "STARTING HADOOP"

$base_dir/hadoop/current/bin/start-all.sh



## ZOOKEEPER INSTALL ##

#ZOOKEEPER MIRRORS
#http://mirrors.gigenet.com/apache/zookeeper
#http://mirror.sdunix.com/apache/zookeeper
#http://apache.petsads.us/zookeeper

zookeeper_version=3.3.6
zookeeper_file_name=zookeeper-$zookeeper_version
zookeeper_download=$zookeeper_file_name.tar.gz
zookeeper_mirror=http://mirrors.gigenet.com/apache/zookeeper
zookeeper_download_uri=$zookeeper_mirror/$zookeeper_file_name/$zookeeper_download

cd $base_dir/zookeeper


#echo "downloading zookeeper version $zookeeper_version from $zookeeper_mirror"
#$downloadType $zookeeper_download_uri

tar -xvf $zookeeper_download

ln -s $zookeeper_file_name current

mkdir $base_dir/zookeeper/current/data

cat <<EOF > $base_dir/zookeeper/current/conf/zoo.cfg
tickTime=2000
dataDir=$base_dir/zookeeper/current/data
clientPort=2181
maxClientCnxns=100
EOF


echo "starting zookeeper"
$base_dir/zookeeper/current/bin/zkServer.sh start


























