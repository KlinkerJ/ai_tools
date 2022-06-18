#/bin/bash

#Making sure this script is run as root
if [ "$EUID" -ne 0 ];then
  echo "Please run as root"
  exit
fi

apt-get update && apt-get install curl

#Check if Docker is installed
if [ -x "$(command -v docker)" ]; then
  echo "Docker is already installed, proceeding"
else
  echo "Installing Docker Engine..."
  curl -fsSL https://get.docker.com -o get-docker.sh
  sh get-docker.sh
  echo "Enabling Docker..."
  systemctl --now enable docker
fi

#Add users to Group
read -p 'Enter your local username to get access to docker without sudo:' username
if [[ $var ]]; then
  groupadd docker
  usermod -aG docker $username
fi

#Setup NVIDIA-Docker
echo "Setting up NVIDIA-Docker"
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
      && curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
      && curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
            sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
            tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

apt-get update && apt-get install -y nvidia-docker2
echo "Restarting Docker-Engine"
systemctl restart docker
echo "Installed NVIDIA-Docker"
