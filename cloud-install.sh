#!/bin/bash

downloadType="wget"
hadoop_version="1.1.2"
hadoop_download_name="hadoop-$hadoop_version"
hadoop_download_file="$hadoop_download_name.tar.gz"
hadoop_download_file_asc="$hadoop_download_name.tar.gz.asc"
hadoop_download_mirror="http://apache.petsads.us/hadoop/common"
hadoop_download_location="$hadoop_download_mirror/$hadoop_download_name/$hadoop_download_file"
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

echo "downloading hadoop version $hadoop_version from $hadoop_download_mirror"
$downloadType $hadoop_download_location
  
echo "downloaded hadoop artifact"
cd tmp/cloud/hadoop

tar -xvf ../../../$hadoop_download_file

ln -s $hadoop_download_name current

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




