#/bin/bash

#Creating a Tensorflow-Container
echo "Creating a Tensorflow-Container with GPU and Jupyter, mounting at $HOME/notebooks"
docker run -it -d --name tf-gpu --runtime=nvidia -v $HOME/notebooks):/tf/notebooks tensorflow/tensorflow:latest-gpu-jupyter python
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
