#Hadoop, Zookeeper & Accumulo Bash Installer


The following script will install and start a single node instance of Hadoop, Zookeeper and Accumulo.  `./bin/nuvol.sh` will start the installation process. 

By default the script will install all 3 libraries in `/usr/local/cloud`.  Use `-i` with a preferred location to install elsewhere. 

The script follows installation instructions provided by Sqrrl. [http://blog.sqrrl.com/post/40578606670/quick-accumulo-install](http://blog.sqrrl.com/post/40578606670/quick-accumulo-install)



##Confirm installation by browsing to

###Name Node Monitor 
[http://localhost:50070](http://localhost:50070)

###Job Tracker Monitor 
[http://localhost:50030](http://localhost:50030)

###Accumulo Monitor page 
[http://localhost:50095](http://localhost:50095)




















