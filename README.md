# Description

This respository is used to collect various useful scripts and programs for AI and Machine Learning.

# Usage
1. Clone this repo with `git clone https://github.com/KlinkerJ/ai_tools.git`
2. Use `cd ai_tools` to switch to the cloned repo.

## Create a Docker-Container with GPU acceleration
1. Switch the directory with `cd gpu_acceleration`
2. Make sure your computer does have a NVIDIA GPU installed in it!
3. If you do not have already installed cuda-drivers, you can do so by executing `sudo install_cuda_drivers.sh`
4. Then, execute `install_docker_for_nvidia.sh` to install the nvidia runtime and docker itself.
    a) You should enter a username in the process so that user does not have to use `sudo` to access docker.  
5. Call `create_tensorflow_container.sh` to create the container with a mountpoint under `~/notebooks`. This directory is accessable under `notebooks` inside of the container.
    a) The script asks for additional python modules to get installed. For scientific reasons, we install Numpy, Scipy, Matplotlib automatically.
