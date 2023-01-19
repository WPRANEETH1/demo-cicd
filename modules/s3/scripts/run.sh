#!/bin/sh

export JENKINS_HOME=/data/jenkins
set JENKINS_HOME=/data/jenkins
java -Dmail.smtp.starttls.enable="true" -Dmail.smtp.ssl.protocols=TLSv1.2  -jar jenkins.war --httpPort=80 --prefix=/ &
