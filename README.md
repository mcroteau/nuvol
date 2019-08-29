# Hadoop, Zookeeper & Accumulo Bash Installer

The following script will install and start a single node instance of Hadoop, Zookeeper and Accumulo.  `./bin/nuvol.sh` will kick off the installation process. 

By default the script will install all 3 artifacts in `/usr/local/cloud`.  Use `-i` with a preferred location to install elsewhere. 

Once the installation script has downloaded and installed everything, you will be prompted to give Accumulo an instance name and a password for root. 


Confirm installation by browsing to :

#### Name Node Monitor 
[http://localhost:50070](http://localhost:50070)

#### Job Tracker Monitor 
[http://localhost:50030](http://localhost:50030)

#### Accumulo Monitor page 
[http://localhost:50095](http://localhost:50095)


***

##### * Note `JAVA_HOME` must be set


##### * The script follows installation instructions provided by Sqrrl.
 [http://blog.sqrrl.com/post/40578606670/quick-accumulo-install](http://blog.sqrrl.com/post/40578606670/quick-accumulo-install)
 
 ##### Updated























