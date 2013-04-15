#HADOOP + ZOOKEEPER + ACCUMULO Installation Script

References : 
https://hortonworks.com/kb/generating-ssh-keys-for-passwordless-login/
http://blog.sqrrl.com/post/40578606670/quick-accumulo-install


Cloud Installation

create cloud directories

/usr/local/cloud/hadoop
/usr/local/cloud/hadoop/hdfs
/usr/local/cloud/zookeeper
/usr/local/cloud/accumulo


create hdfs keys with no password

ssh-keygen -t dsa -P '' -f ~/.ssh/id_hadoop_dsa

cat ~/.ssh/id_hadoop_dsa.pub >> ~/.ssh/authorized_keys

ssh-add ~/.ssh/id_hadoop_dsa


download hadoop

wget or curl -O 
 
Hadoop Mirrors
http://apache.petsads.us/hadoop/common/hadoop-<version>/<file>
http://www.poolsaboveground.com/apache/hadoop/common/hadoop-<version>/<file>
http://mirror.cc.columbia.edu/pub/software/apache/hadoop/common/hadoop-<version>/<file>


Hadoop Files
hadoop-<version>.tar.gz
hadoop-<version>.tar.gz.asc

untar hadoop-<version>.tar.gz /usr/local/hadoop
create a symbolic link to hadoop-<version> hadoop-current

edit conf/hadoop-env.sh



add HADOOP_HOME to path

add configuration to 
conf/core-site.xml

<configuration>
	<property>
		<name>fs.default.name</name>
		<value>hdfs://localhost:9000</value>
	</property>
</configuration>


add next lines to conf/hdfs-site.xml

<configuration>
	<property>
		<name>dfs.data.dir</name>
		<value>/usr/local/cloud/hadoop/hdfs/data</value>
	</property>
	<property>
		<name>dfs.name.dir</name>
		<value>/usr/local/cloud/hadoop/hdfs/name</value>
	</property>
	<property>
		<name>dfs.replication</name>
		<value>1</value>
	</property>
</configuration>


add to conf/mapred-site.xml

<configuration>
	<property>
		<name>mapred.job.tracker</name>
		<value>localhost:9001</value>
	</property>
</configuration>


format new distributed filesystem

/usr/local/cloud/hadoop/current/bin/hadoop namenode -format


start hadoop daemons

/usr/local/cloud/hadoop/current/bin/start-all.sh




INSTALL ZOOKEEPER

Download & untar Zookeeper package from one of the mirrors below

http://mirrors.gigenet.com/apache/zookeeper/zookeeper-<version>/<file>
http://mirror.sdunix.com/apache/zookeeper/zookeeper-<version>/<file>
http://apache.petsads.us/zookeeper/zookeeper-<version>/<file>

create symbolic link to /usr/local/cloud/zookeeper/zookeeper-<version> current

create a /usr/local/cloud/zookeeper/current/conf/zoo.cfg with contents below : 

tickTime=2000
dataDir=/var/lib/zookeeper
clientPort=2181
maxClientCnxns=100


start zookeeper

/usr/local/cloud/zookeeper/current/bin/zkServer.sh start





INSTALL ACCUMULO

Download & untar Accumulo package from one of the mirrors below

http://mirror.sdunix.com/apache/accumulo/<version>/<file>
http://apache.claz.org/accumulo/<version>/<file>
http://download.nextag.com/apache/accumulo/<version>/<file>


create symbolic link to /usr/local/cloud/accumulo/accumulo-<version> current

copy simple example configuration files 

cp conf/examples/512MB/standalone/* conf

Edit conf/accumulo-env.sh to set your JAVA_HOME, HADOOP_HOME, ZOOKEEPER_HOME, and ACCUMULO_HOME.

JAVA_HOME="`eval echo $JAVA_HOME`"
HADOOP_HOME=/usr/local/cloud/hadoop/current
ZOOKEEPER_HOME=/usr/local/cloud/zookeeper/current
ACCUMULO_HOME=/usr/local/cloud/accumulo/current

create 'logs' directory for accumulo logging in ACCUMULO_HOME


Run “bin/accumulo init” to create the HDFS directory structure and initial ZooKeeper settings. 
Choose a name and root password for your instance when prompted.


Start Accumulo using the bin/start-all.sh script.

Browse to the Accumulo Monitor page http://localhost:50095  to confirm you are live



















