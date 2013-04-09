hadoop_version=${hadoop_version:-1.1.2}

function hadoop(){
	echo $script_dir
	for mirror in "${hadoop_mirrors[@]}"
	do
		site=$(echo $mirror | sed "s/version/${hadoop_version}/g")
		echo $site
		ping -c1 $site > /dev/null && echo "YES" || echo "NO"
		
		echo ${hadoop_version}
		echo $hadoop_version
		
	done
}