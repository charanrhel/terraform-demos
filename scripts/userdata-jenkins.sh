#!/bin/bash
# sudo yum install java-1.11.0-openjdk
#url https://www.jenkins.io/doc/tutorials/tutorial-for-installing-jenkins-on-AWS/
sudo amazon-linux-extras install java-openjdk11
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum install jenkins
systemctl enable jenkins 
systemctl start jenkins 


#2nd way

# sudo wget -O /etc/yum.repos.d/jenkins.repo \
#     https://pkg.jenkins.io/redhat-stable/jenkins.repo
# sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
# sudo yum upgrade
# # Add required dependencies for the jenkins package
# sudo yum install java-11-openjdk
# sudo yum install jenkins
# sudo systemctl daemon-reload