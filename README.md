#Hadoop, Zookeeper & Accumulo Bash Installer


create cloud directories

<pre><code>/usr/local/cloud/hadoop
/usr/local/cloud/hadoop/hdfs
/usr/local/cloud/zookeeper
/usr/local/cloud/accumulo
</code></pre>

create hdfs keys with no password

ssh-keygen -t dsa -P '' -f ~/.ssh/id_hadoop_dsa

cat ~/.ssh/id_hadoop_dsa.pub &gt;&gt; ~/.ssh/authorized_keys

ssh-add ~/.ssh/id_hadoop_dsa


##Install Hadoop

download hadoop

wget or curl -O 
 
Hadoop Mirrors
```
http://apache.petsads.us/hadoop/common/hadoop-&lt;version&gt;/&lt;file&gt;
http://www.poolsaboveground.com/apache/hadoop/common/hadoop-&lt;version&gt;/&lt;file&gt;
http://mirror.cc.columbia.edu/pub/software/apache/hadoop/common/hadoop-&lt;version&gt;/&lt;file&gt;
```

Hadoop Files
```
hadoop-&lt;version&gt;.tar.gz
hadoop-&lt;version&gt;.tar.gz.asc
```

untar hadoop-&lt;version&gt;.tar.gz /usr/local/hadoop

create a symbolic link to hadoop-&lt;version&gt; hadoop-current

edit conf/hadoop-env.sh



add HADOOP_HOME to path

add configuration to 
conf/core-site.xml

<pre><code>&lt;configuration&gt;
	&lt;property&gt;
		&lt;name&gt;fs.default.name&lt;/name&gt;
		&lt;value&gt;hdfs://localhost:9000&lt;/value&gt;
	&lt;/property&gt;
&lt;/configuration&gt;
</code></pre>

add next lines to conf/hdfs-site.xml

<pre><code>&lt;configuration&gt;
	&lt;property&gt;
		&lt;name&gt;dfs.data.dir&lt;/name&gt;
		&lt;value&gt;/usr/local/cloud/hadoop/hdfs/data&lt;/value&gt;
	&lt;/property&gt;
	&lt;property&gt;
		&lt;name&gt;dfs.name.dir&lt;/name&gt;
		&lt;value&gt;/usr/local/cloud/hadoop/hdfs/name&lt;/value&gt;
	&lt;/property&gt;
	&lt;property&gt;
		&lt;name&gt;dfs.replication&lt;/name&gt;
		&lt;value&gt;1&lt;/value&gt;
	&lt;/property&gt;
&lt;/configuration&gt;
</code></pre>

add to `conf/mapred-site.xml`

<pre><code>&lt;configuration&gt;
	&lt;property&gt;
		&lt;name&gt;mapred.job.tracker&lt;/name&gt;
		&lt;value&gt;localhost:9001&lt;/value&gt;
	&lt;/property&gt;
&lt;/configuration&gt;
</code></pre>


format new distributed filesystem

`/usr/local/cloud/hadoop/current/bin/hadoop namenode -format`


start hadoop daemons

`/usr/local/cloud/hadoop/current/bin/start-all.sh`




##Install Zookeeper

Download & untar Zookeeper package from one of the mirrors below

http://mirrors.gigenet.com/apache/zookeeper/zookeeper-&lt;version&gt;/&lt;file&gt;
http://mirror.sdunix.com/apache/zookeeper/zookeeper-&lt;version&gt;/&lt;file&gt;
http://apache.petsads.us/zookeeper/zookeeper-&lt;version&gt;/&lt;file&gt;

create symbolic link to /usr/local/cloud/zookeeper/zookeeper-&lt;version&gt; current

create a /usr/local/cloud/zookeeper/current/conf/zoo.cfg with contents below : 

tickTime=2000
dataDir=/var/lib/zookeeper
clientPort=2181
maxClientCnxns=100


start zookeeper

/usr/local/cloud/zookeeper/current/bin/zkServer.sh start





##Install Accumulo

Download & untar Accumulo package from one of the mirrors below

http://mirror.sdunix.com/apache/accumulo/&lt;version&gt;/&lt;file&gt;
http://apache.claz.org/accumulo/&lt;version&gt;/&lt;file&gt;
http://download.nextag.com/apache/accumulo/&lt;version&gt;/&lt;file&gt;


create symbolic link to /usr/local/cloud/accumulo/accumulo-&lt;version&gt; current

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


####References : 
[http://blog.sqrrl.com/post/40578606670/quick-accumulo-install](http://blog.sqrrl.com/post/40578606670/quick-accumulo-install)



















