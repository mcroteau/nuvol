#!/bin/bash

JAVA_HOME=$(echo $JAVA_HOME)
DOWNLOAD_TYPE="curl -O"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source ${SCRIPT_DIR}/util.sh
source ${SCRIPT_DIR}/mirrors.sh
source ${SCRIPT_DIR}/hadoop.sh
source ${SCRIPT_DIR}/zookeeper.sh
source ${SCRIPT_DIR}/accumulo.sh

INSTALL_DIR=${INSTALL_DIR:-/usr/local/cloud}

mkdir -p ${INSTALL_DIR}/hadoop
mkdir -p ${INSTALL_DIR}/hadoop/hdfs
mkdir -p ${INSTALL_DIR}/zookeeper
mkdir -p ${INSTALL_DIR}/accumulo

installHadoop
installZookeeper
installAccumulo