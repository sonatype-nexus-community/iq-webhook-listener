#!/bin/sh
echo "******* THIS IS A QUAY REPO HOOK*******"
echo $1
echo $2
echo $3
echo $4

AppID=${3/\//\_}
echo $AppID

cd /etc/webhook;
# Login if anonymous pull isn't enable
# docker login https://registry.mycompany.com:5000 -u admin -p admin123

#Pull image
docker pull registry.mycompany.com:5000/$3:$4
# Save image
docker save -o $AppID.tar registry.mycompany.com:5000/$3:$4
#scan
java -jar nexus-iq-cli.jar -s http://iq-server:8070 -i $AppID -t release -a admin:admin $AppID.tar

#clean up
ls -la
rm $AppID.tar
ls -la
echo "******* END QUAY REPO HOOK ***********"

#  Payload from a repository push in quay
#
#   {
#   "name": "repository",
#   "repository": "mynamespace/repository",
#   "namespace": "mynamespace",
#   "docker_url": "quay.io/mynamespace/repository",
#   "homepage": "https://quay.io/repository/mynamespace/repository",
#   "updated_tags": [
#     "latest"
#   ]
# }