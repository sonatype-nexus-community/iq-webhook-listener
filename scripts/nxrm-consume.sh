#!/bin/sh
echo "******* THIS IS A NEXUS REPO HOOK*******"
echo $1
echo $2
echo $3
echo $4
cd /etc/webhook;
docker login nexus:18444 -u admin -p admin123
docker pull nexus:18444/$3:$4
docker save -o docker.tar nexus:18444/$3:$4
java -jar nexus-iq-cli.jar -s http://iq-server:8070 -i juice-shop -a admin:admin123 docker.tar
ls -la
rm docker.tar
docker rmi nexus:18444/$3:$4
ls -la
echo "******* END DEBUG ***********"

