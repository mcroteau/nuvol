## ZOOKEEPER INSTALL ##

#ZOOKEEPER MIRRORS
#http://mirrors.gigenet.com/apache/zookeeper
#http://mirror.sdunix.com/apache/zookeeper
#http://apache.petsads.us/zookeeper

zookeeper_version=3.3.6
zookeeper_file_name=zookeeper-$zookeeper_version
zookeeper_download=$zookeeper_file_name.tar.gz
zookeeper_mirror=http://mirrors.gigenet.com/apache/zookeeper
zookeeper_download_uri=$zookeeper_mirror/$zookeeper_file_name/$zookeeper_download


cd tmp/cloud/zookeeper

echo "downloading zookeeper version $zookeeper_version from $zookeeper_mirror"
# wget $zookeeper_download_uri

tar -xvf $zookeeper_download

ln -s $zookeeper_file_name current


cat <<EOF > current/conf/zoo.cfg
tickTime=2000
dataDir=/Users/mcroteau/Desktop/CloudArtifacts/tmp/cloud/zookeeper/current/data
clientPort=2181
maxClientCnxns=100
EOF


echo "starting zookeeper"
/Users/mcroteau/Desktop/CloudArtifacts/tmp/cloud/zookeeper/current/bin/zkServer.sh start


