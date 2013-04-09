
downloadType="wget"
base_dir=/usr/local/tmp/cloud





## ACCUMULO INSTALL ##

#ACCUMULO MIRRORS
#http://mirror.sdunix.com/apache/accumulo/<version>/<file>
#http://apache.claz.org/accumulo/<version>/<file>
#http://download.nextag.com/apache/accumulo/<version>/<file>

accumulo_version=1.4.2
accumulo_file_name=accumulo-$accumulo_version
accumulo_download=$accumulo_file_name-dist.tar.gz
accumulo_mirror=http://mirror.sdunix.com/apache/accumulo
accumulo_download_uri=$accumulo_mirror/$accumulo_version/$accumulo_download

cd $base_dir/accumulo

#echo "downloading accumulo version $accumulo_version from $accumulo_download_uri"
#wget $accumulo_download_uri

tar -xvf $accumulo_download

ln -s $accumulo_file_name current

cp $base_dir/accumulo/current/conf/examples/512MB/standalone/* $base_dir/accumulo/current/conf/


sed -i.bak "s:/path/to/java:${JAVA_HOME}:;\
            s:/path/to/hadoop:${HADOOP_HOME}:;\
            s:/path/to/zookeeper:${ZOOKEEPER_HOME}:;\
            s:-Xss128k:-Xss256k:" "$base_dir/accumulo/current/conf/accumulo-env.sh"



mkdir $base_dir/accumulo/current/logs

$base_dir/accumulo/current/bin/accumulo init

$base_dir/accumulo/current/bin/start-all.sh
