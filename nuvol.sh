#!/bin/bash

#http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

while getopts "v:" flag; do
    case $flag in
        v)
            hadoop_version=$OPTARG
            echo "Using Hadoop Version"
            ;;
    esac
done
	

source ${script_dir}/mirrors.sh
source ${script_dir}/hadoop.sh

hadoop
