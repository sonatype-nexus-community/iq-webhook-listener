FROM    almir/webhook

RUN     apk update && apk upgrade && apk add openjdk8-jre

COPY 	hooks/quay.json hooks/jenkins.json hooks/nxrm-prime.json hooks/dockerHub-scan.json hooks/iq-consume.json hooks/nxrm-consume.json hooks/test.json /etc/webhook/
COPY	scripts/quayScan.sh scripts/jenkins.sh scripts/nxrm-prime.sh scripts/dockerHub-scan.sh scripts/iq-consume.sh scripts/nxrm-consume.sh scripts/test.sh /etc/webhook/

COPY	nexus-iq-cli-1.60.0-02.jar /etc/webhook/nexus-iq-cli.jar
