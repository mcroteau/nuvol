SCRIPT_DIR="`eval pwd`"
base_dir=/usr/local/tmp

echo ${SCRIPT_DIR}
echo $SCRIPT_DIR

source ${SCRIPT_DIR}/hadoop.sh

hadoop
