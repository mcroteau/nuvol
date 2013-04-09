#Global variables include HADOOP_VERSION, HADOOP_DOWNLOAD_URI, HADOOP_FILE, HADOOP_FILE_PREFIX
HADOOP_VERSION=${HADOOP_VERSION:-1.1.2}
HADOOP_FILE=hadoop-${HADOOP_VERSION}
DEVELOPMENT=false

function installHadoop(){
	setDownloadUri
	navigateHadoopDir
	downloadHadoop
	configureHadoop
}

function configureHadoop(){
	setCurrent
	setJavaHome
	configureCore
	configureHdfs
	configureMapred
	formatNamenode
	startHadoop
}


function formatNamenode(){
	${INSTALL_DIR}/hadoop/current/bin/hadoop namenode -format
}


function startHadoop(){
	echo "STARTING HADOOP"
	${INSTALL_DIR}/hadoop/current/bin/start-all.sh
}


function setCurrent(){
	$(tar -xvf $HADOOP_FILE.tar.gz)
	$(ln -s $HADOOP_FILE current)	
}


function setJavaHome(){
	sed -i .bak '/export JAVA_HOME/a \
	export JAVA_HOME='"$(echo $JAVA_HOME)" $INSTALL_DIR/hadoop/current/conf/hadoop-env.sh
}


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

function navigateHadoopDir(){
	cd $INSTALL_DIR/hadoop
}

function downloadHadoop(){
	if [ ${DEVELOPMENT} == true ]
	then
		echo "in development"
		cp ${HADOOP_FILE} ${INSTALL_DIR/hadoop/}
	else
		echo "downloading ${HADOOP_DOWNLOAD_URI}"
		${DOWNLOAD_TYPE} ${HADOOP_DOWNLOAD_URI}
	fi	
}


function setDownloadUri(){
	
	for mirror in "${HADOOP_MIRRORS[@]}"
	do
		local host=$(echo $mirror | awk -F/ '{print $3}')
		local site=$(echo $mirror | sed "s/version/${HADOOP_VERSION}/g")
		local available=$(ping -c1 $host > /dev/null && echo "YES" || echo "NO")
		if [[ $available == "YES" ]]; then
			HADOOP_DOWNLOAD_URI=$site
			break;
		else
			echo "unable to reach $host"
		fi		
	done	
		
	return 0
}