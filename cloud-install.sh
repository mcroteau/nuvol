#!/bin/bash

downloadType="wget"


## HADOOP INSTALL ##
hadoop_version="1.1.2"
hadoop_file_name="hadoop-$hadoop_version"
hadoop_download="$hadoop_file_name.tar.gz"
hadoop_mirror="http://apache.petsads.us/hadoop/common"
hadoop_download_uri="$hadoop_mirror/$hadoop_file_name/$hadoop_download"
#http://apache.petsads.us/hadoop/common/hadoop-<version>/<file>
#http://www.poolsaboveground.com/apache/hadoop/common/hadoop-<version>/<file>
#http://mirror.cc.columbia.edu/pub/software/apache/hadoop/common/hadoop-<version>/<file>

echo "staring cloud installation..."

echo "creating directories"

mkdir -p tmp/cloud/hadoop
mkdir -p tmp/cloud/hadoop/hdfs
mkdir -p tmp/cloud/zookeeper
mkdir -p tmp/cloud/accumulo

echo "directories created"


cd tmp/cloud/hadoop

echo "downloading hadoop version $hadoop_version from $hadoop_mirror"
$downloadType $hadoop_download_uri
  
echo "downloaded hadoop artifact"

tar -xvf $hadoop_download

ln -s $hadoop_file_name current

d=$(pwd)
echo "current directory $d"

java_home=$(echo $JAVA_HOME)

echo "setting JAVA_HOME in hadoop/current/conf/hadoop-env-back.sh -> $java_home"

d=$(pwd)
echo "current directory $d"
sed -i .bak '/export JAVA_HOME/a \
export JAVA_HOME='"$(echo $JAVA_HOME)" current/conf/hadoop-env.sh

cat <<EOF > current/conf/core-site.xml
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



cat <<EOF > current/conf/hdfs-site.xml
<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>

<!-- Put site-specific property overrides in this file. -->

<configuration>
	<property>
		<name>dfs.data.dir</name>
		<value>/Users/mcroteau/Desktop/CloudArtifacts/tmp/cloud/hadoop/hdfs/data</value>
	</property>
	<property>
		<name>dfs.name.dir</name>
		<value>/Users/mcroteau/Desktop/CloudArtifacts/tmp/cloud/hadoop/hdfs/name</value>
	</property>
	<property>
		<name>dfs.replication</name>
		<value>1</value>
	</property>
</configuration>
EOF


cat <<EOF > current/conf/mapred-site.xml
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




/Users/mcroteau/Desktop/CloudArtifacts/tmp/cloud/hadoop/current/bin/hadoop namenode -format

echo "STARTING HADOOP"

/Users/mcroteau/Desktop/CloudArtifacts/tmp/cloud/hadoop/current/bin/start-all.sh




## ZOOKEEPER INSTALL ##

#ZOOKEEPER MIRRORS
#http://mirrors.gigenet.com/apache/zookeeper
#http://mirror.sdunix.com/apache/zookeeper
#http://apache.petsads.us/zookeeper

zookeeper_version=3.3.6
zookeeper_file_name=hadoop-$zookeeper_version
zookeeper_download=$zookeeper_file_name.tar.gz
zookeeper_mirror=http://mirrors.gigenet.com/apache/zookeeper
zookeeper_download_uri=$zookeeper_mirror/$zookeeper_file_name/$zookeeper_download


echo "downloading zookeeper version $zookeeper_version from $zookeeper_mirror"
wget $zookeeper_download_uri
  
























