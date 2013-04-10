#Global variables include ACCUMULO_VERSION, ACCUMULO_DOWNLOAD_URI, ACCUMULO_FILE, ACCUMULO_FILE_PREFIX
ACCUMULO_VERSION=${ACCUMULO_VERSION:-1.4.2}
ACCUMULO_FILE=accumulo-${ACCUMULO_VERSION}
DEVELOPMENT=false

function installAccumulo(){
	setAccumuloDownloadUri
	navigateAccumuloDir
	downloadAccumulo
	configureAccumulo
}

function configureAccumulo(){
	setAccumuloCurrent
	copyConfigs
	setupEnvironment
	createLogsDir
	initializeAccumulo
	startAccumulo
}

function setAccumuloCurrent(){
	$(tar -xvf ${ACCUMULO_FILE}-dist.tar.gz)
	$(ln -s ${ACCUMULO_FILE} current)	
}

function copyConfigs(){	
	$(cp ${INSTALL_DIR}/accumulo/current/conf/examples/512MB/standalone/* ${INSTALL_DIR}/accumulo/current/conf/)
}

function setupEnvironment(){
	sed -i.bak "s:/path/to/java:$(echo $JAVA_HOME):;\
	            s:/path/to/hadoop:${INSTALL_DIR}/hadoop/current:;\
	            s:/path/to/zookeeper:${INSTALL_DIR}/zookeeper/current:;\
	            s:-Xss128k:-Xss256k:" "${INSTALL_DIR}/accumulo/current/conf/accumulo-env.sh"
}

function createLogsDir(){
	mkdir ${INSTALL_DIR}/accumulo/current/logs
}

function initializeAccumulo(){
	${INSTALL_DIR}/accumulo/current/bin/accumulo init
}

function startAccumulo(){
	echo "STARTING ACCUMULO"
	${INSTALL_DIR}/accumulo/current/bin/start-all.sh
}


function navigateAccumuloDir(){
	cd ${INSTALL_DIR}/accumulo
}


function downloadAccumulo(){
	if [ ${DEVELOPMENT} == true ]
	then
		echo "in development"
		cp ${ACCUMULO_FILE} ${INSTALL_DIR/accumulo/}
	else
		echo "downloading ${ACCUMULO_DOWNLOAD_URI}"
		${DOWNLOAD_TYPE} ${ACCUMULO_DOWNLOAD_URI}
	fi	
}


function setAccumuloDownloadUri(){
	
	for mirror in "${ACCUMULO_MIRRORS[@]}"
	do
		local host=$(echo $mirror | awk -F/ '{print $3}')
		local site=$(echo $mirror | sed "s/version/${ACCUMULO_VERSION}/g")
		local available=$(ping -c1 $host > /dev/null && echo "YES" || echo "NO")
		if [[ $available == "YES" ]]; then
			ACCUMULO_DOWNLOAD_URI=$site
			break;
		else
			echo "unable to reach $host"
		fi		
	done	
		
	return 0
}