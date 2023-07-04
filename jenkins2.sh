#!/bin/bash
echo "añadiendo apt-keys de jenkins"
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "actualizando apt-get"
sudo apt-get -qq update

echo "Instalando default-java"
sudo apt-get -y install default-jre > /dev/null 2>&1
sudo apt-get -y install default-jdk > /dev/null 2>&1

echo "Instalando git"
sudo apt-get -y install git > /dev/null 2>&1

echo "Instalando git-ftp"
sudo apt-get -y install git-ftp > /dev/null 2>&1

echo "instalando docker"
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y > /dev/null 2>&1


echo "Instalando jenkins"
sudo apt-get -y install jenkins --allow-unauthenticated > /dev/null 2>&1
sudo usermod -aG docker jenkins
sudo service jenkins start


sleep 1m


cp /var/lib/jenkins/secrets/initialAdminPassword /sharedData/jenkinsadmin
