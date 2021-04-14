#!/usr/bin/env bash
sudo yum install java-1.8.0-openjdk-devel
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
sudo yum install jenkins
sudo service jenkins start
##  Open 8080 in aws security groupt
## Check the default admin password for further set-up sudo cat /var/lib/jenkins/secrets/initialAdminPassword
