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

cd tmp/cloud/accumulo

echo "downloading accumulo version $accumulo_version from $accumulo_download_uri"
wget $accumulo_download_uri

tar -xvf $accumulo_download

ln -s $accumulo_file_name current



