function usage() {
        echo
        echo " Usage: "
        echo
        echo "   Options:"
        echo "      -i  <installation-directory>  will install all artifacts in this directory"
        echo
        exit 0
}
while getopts "h:i:help" flag; do
    case $flag in
	    i)
	        INSTALL_DIR=$OPTARG
	        echo "Installation Directory set to ${INSTALL_DIR}"
	        ;;	
        h)
	        usage
            ;;
    esac
done

if [[ -z $(echo $JAVA_HOME) ]] 
then
	echo "*****************************************"
	echo "JAVA_HOME environment variable is not set"
	echo "*****************************************"
	exit 0
fi
