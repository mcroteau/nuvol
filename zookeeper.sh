#Global variables include ZOOKEEPER_VERSION, ZOOKEEPER_DOWNLOAD_URI, ZOOKEEPER_FILE, ZOOKEEPER_FILE_PREFIX
ZOOKEEPER_VERSION=${ZOOKEEPER_VERSION:-3.3.6}
ZOOKEEPER_FILE=zookeeper-${ZOOKEEPER_VERSION}
DEVELOPMENT=true

function installZookeeper(){
	setDownloadUri
	navigateZookeeperDir
	downloadZookeeper
	configureZookeeper
}

function configureZookeeper(){
	setCurrent
	createDataDir
	configureZooConfig
	startZookeeper
}

function setCurrent(){
	$(tar -xvf ${ZOOKEEPER_FILE}.tar.gz)
	$(ln -s ${ZOOKEEPER_FILE} current)	
}

function createDataDir(){	
	mkdir ${INSTALL_DIR}/zookeeper/current/data
}


function configureZooConfig(){
	cat <<EOF > ${INSTALL_DIR}/zookeeper/current/conf/zoo.cfg
tickTime=2000
dataDir=${INSTALL_DIR}/zookeeper/current/data
clientPort=2181
maxClientCnxns=100
EOF
}


function startZookeeper(){
	echo "STARTING ZOOKEEPER"
	${INSTALL_DIR}/zookeeper/current/bin/zkServer.sh start
}


function navigateZookeeperDir(){
	cd ${INSTALL_DIR}/zookeeper
}


function downloadZookeeper(){
	if [ ${DEVELOPMENT} == true ]
	then
		echo "in development"
		cp ${ZOOKEEPER_FILE} ${INSTALL_DIR/zookeeper/}
	else
		echo "downloading ${ZOOKEEPER_DOWNLOAD_URI}"
		${DOWNLOAD_TYPE} ${ZOOKEEPER_DOWNLOAD_URI}
	fi	
}


function setDownloadUri(){
	
	for mirror in "${ZOOKEEPER_MIRRORS[@]}"
	do
		local host=$(echo $mirror | awk -F/ '{print $3}')
		local site=$(echo $mirror | sed "s/version/${ZOOKEEPER_VERSION}/g")
		local available=$(ping -c1 $host > /dev/null && echo "YES" || echo "NO")
		if [[ $available == "YES" ]]; then
			ZOOKEEPER_DOWNLOAD_URI=$site
			break;
		else
			echo "unable to reach $host"
		fi		
	done	
		
	return 0
}