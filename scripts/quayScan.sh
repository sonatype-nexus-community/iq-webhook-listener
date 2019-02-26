#!/bin/sh
#exec > /etc/webhook/output.log 2>&1

# Initial Setup
cd /etc/webhook;
URL='quay.io'


# Docker Scan Function to Call

doDockerScan () {
	echo $1
	docker pull $1
	docker save -o docker.tar $1
	ls -lah
	java -jar nexus-iq-cli.jar -s http://iq-server:8070 -i $2 -a admin:admin123 docker.tar
	rm docker.tar
	docker rmi $1
	ls -lah
}


# Debugging Stuff 
echo "~~~~~~~~~~~~~~~~~Payload~~~~~~~~~~~~~~~~~"
echo $1 # Entire Payload
echo "~~~~~~~~~~~~~~~~~Docker URL~~~~~~~~~~~~~~~~~"
echo $2 # Docker URL
echo "~~~~~~~~~~~~~~~~~Updated Tags~~~~~~~~~~~~~~~~~"
echo $3 # Updated Tags
echo "~~~~~~~~~~~~~~~~~Trimmed Tags~~~~~~~~~~~~~~~~~"
trimmedTags=`echo $3 | sed 's/[][]//g'`
echo $trimmedTags
echo "~~~~~~~~~~~~~~~~~Name~~~~~~~~~~~~~~~~~"
echo $4 # Name
echo "~~~~~~~~~~~~~~~~~namespace~~~~~~~~~~~~~~~~~"
echo $5 # namespace


# Call of Function/Scan
DockerPull=$URL/$5/$4:$trimmedTags
doDockerScan $DockerPull $4

