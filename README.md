#HADOOP + ZOOKEEPER + ACCUMULO Installation Script

http://blog.sqrrl.com/post/40578606670/quick-accumulo-install
http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
http://github.com/mjwall/accumulo-bash-installer


function configureCore(){	
cat <<EOF > ${INSTALL_DIR}/hadoop/current/conf/core-site.xml
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
}

function configureHdfs(){
cat <<EOF > ${INSTALL_DIR}/hadoop/current/conf/hdfs-site.xml
<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>

<!-- Put site-specific property overrides in this file. -->

<configuration>
	<property>
		<name>dfs.data.dir</name>
		<value>${INSTALL_DIR}/hadoop/hdfs/data</value>
	</property>
	<property>
		<name>dfs.name.dir</name>
		<value>${INSTALL_DIR}/hadoop/hdfs/name</value>
	</property>
	<property>
		<name>dfs.replication</name>
		<value>1</value>
	</property>
</configuration>
EOF	
}


function configureMapred(){
cat <<EOF > ${INSTALL_DIR}/hadoop/current/conf/mapred-site.xml
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
}
