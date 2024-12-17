#! /bin/bash

echo "--------------------------------"
echo "....install gazebo environment...."
echo "--------------------------------"

sudo apt-add-repository ppa:dartsim  
sudo apt update  
sudo apt install -y libdart-dev libdart-utils-dev libdart-external-ikfast-dev libsdformat9-dev libfreeimage-dev libprotoc-dev libprotobuf-dev protobuf-compiler freeglut3-dev libcurl4-openssl-dev libtinyxml-dev libtinyxml2-dev libtar-dev libtbb-dev libogre-1.9-dev libxml2-dev pkg-config qtbase5-dev libqwt-qt5-dev libltdl-dev libgts-dev libboost-thread-dev libboost-system-dev libboost-filesystem-dev libboost-program-options-dev libboost-regex-dev libboost-iostreams-dev libsimbody-dev libignition-common3-dev libignition-fuel-tools4-dev libignition-transport8-dev libignition-math6-dev libignition-msgs5-dev

if [ $(uname -m) == "aarch64" ]; then
    cd ~/Documents/  
    git clone https://github.com/tylee-yeonge/gazebo-classic.git
    cd ~/Documents/gazebo-classic
    mkdir build && cd build  
    cmake ../  
    make -j3  
    sudo make install

    echo "export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH" >> ~/.bashrc
    echo "export PATH=/usr/local/bin:$PATH" >> ~/.bashrc
    echo "export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH" >> ~/.bashrc

    mkdir -p ~/Documents/gazebo_ws/src  
    cd ~/Documents/gazebo_ws/src  
    git clone https://github.com/ros-simulation/gazebo_ros_pkgs  
    cd gazebo_ros_pkgs  
    git checkout ros2
    cd ~/Documents/gazebo_ws  
    colcon build --symlink-install

elif [ $(uname -m) == "x86_64" ]; then
    sudo apt install -y gazebo
    sudo apt install -y ros-humble-ros2-control
    sudo apt install -y ros-humble-ros2-controllers
    sudo apt install -y ros-humble-gazebo-ros-pkgs
    sudo apt install -y ros-humble-gazebo-ros2-control
fi

echo "--------------------------------"
echo "....gazebo environment is correctly set!...."
echo "--------------------------------"