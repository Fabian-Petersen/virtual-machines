#!/bin/bash

set -e

echo "[INFO] Updating system..."
sudo apt-get update -y
sudo apt-get upgrade -y

# $ Step 1: Install Docker
echo "[INFO] Installing dependencies..."
sudo apt-get install ca-certificates curl -y
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# $ Add the repository to apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update -y

echo "[INFO] Installing Docker..."
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

echo "[INFO] Adding vagrant user to docker group..."
sudo usermod -aG docker vagrant

# $ Step 2: Install Jenkins using Docker
echo "[INFO] Pulling Jenkins jdk21 image..."
sudo docker pull jenkins/jenkins:jdk21

echo "[INFO] Running Jenkins container..."
docker run -d --name jenkins \
  -p 8080:8080 -p 50000:50000 \
  -v jenkins_home:/var/jenkins_home \
  jenkins/jenkins:lts

echo "[INFO] Running Jenkins container..."
sudo docker run -d \
  -p 8080:8080 \
  -p 50000:50000 \
  --restart=on-failure \
  -v jenkins_home:/var/jenkins_home \
  --name jenkins \
  jenkins/jenkins:jdk21

echo "[INFO] Jenkins setup complete. Access it at http://192.168.60.21:8080"