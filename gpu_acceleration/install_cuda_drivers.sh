#/bin/bash

#Making sure this script is run as root
if [ "$EUID" -ne 0 ];then
  echo "Please run as root"
  exit
fi

apt-get update && apt-get install curl

#Install CUDA-Drivers
echo "Installing CUDA-Drivers"
#apt-get update && apt-get install -y cuda-drivers
arch=x86_64
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
distro=${distribution//./}
wget https://developer.download.nvidia.com/compute/cuda/repos/$distro/$arch/cuda-keyring_1.0-1_all.deb
dpkg -i cuda-keyring_1.0-1_all.deb
apt-get update && apt-get install -y cuda-drivers



#Creating a Tensorflow-Container
echo "Creating a Tensorflow-Container with GPU and Jupyter, mounting at $(realpath ~/notebooks)"
docker run -it -d --name tf-gpu --runtime=nvidia -v $(realpath ~/notebooks):/tf/notebooks tensorflow/tensorflow:latest-gpu-jupyter python
docker exec tf-gpu pip install numpy matplotlib scipy
echo "Do you want to install additional packages? Numpy, Scipy, Matplotlib are installed automatically."

select yn in "Yes" "No"; do
    case $yn in
        Yes ) make install; break;;
        No ) echo "Which packages do you want to install? You can seperate multiple packages by spaces inbetween (like: deepxde pandas)."; read packages; exit;;
    esac
done

docker exec tf-gpu pip install $packages
echo "Installation finished"

echo "You can access the Jupyter Notebook as follows:
docker logs tf-gpu
exit [n]
