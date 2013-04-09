#Global variables include HADOOP_VERSION, DOWNLOAD_URI, HADOOP_FILE, HADOOP_FILE_PREFIX
HADOOP_VERSION=${HADOOP_VERSION:-1.1.2}
HADOOP_FILE=hadoop-${HADOOP_VERSION}

function installHadoop(){
	setDownloadUri
	downloadHadoop
	configureHadoop
}

function configureHadoop(){
	setCurrent
	setJavaHome
	configureCore
	# configureHdfs
	# configureMapred
}

function setCurrent(){
	$(tar -xvf $HADOOP_FILE.tar.gz)
	$(ln -s $HADOOP_FILE current)	
}

function setJavaHome(){
	sed -i .bak '/export JAVA_HOME/a \
	export JAVA_HOME='"$(${JAVA_HOME})" $INSTALL_DIR/hadoop/current/conf/hadoop-env.sh
}

function configureCore(){	
    local CORE_SITE=$( cat <<-EOF
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
)
    echo "${CORE_SITE}" > "${HADOOP_CONF}/core-site.xml"
}

function downloadHadoop(){
	cd $INSTALL_DIR/hadoop
	echo "downloading ${DOWNlOAD_URI}"
	$(${DOWNLOAD_TYPE} ${DOWNlOAD_URI})		
}


function setDownloadUri(){
	
	for mirror in "${HADOOP_MIRRORS[@]}"
	do
		local host=$(echo $mirror | awk -F/ '{print $3}')
		local site=$(echo $mirror | sed "s/version/${HADOOP_VERSION}/g")
		local available=$(ping -c1 $host > /dev/null && echo "YES" || echo "NO")
		if [[ $available == "YES" ]]; then
			DOWNlOAD_URI=$site
			break;
		else
			echo "unable to reach $host"
		fi		
	done	
		
	return 0
}