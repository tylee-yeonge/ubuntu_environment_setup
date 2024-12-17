#!/bin/bash

set -e

echo "....installing ros2 humble...."

sleep 2

sudo apt update
sudo apt install -y git wget vim build-essential
sudo apt install -y lsb-core lsb-release
sudo apt install -y net-tools iputils-ping git

os_codename=$(lsb_release -cs)


if [ "$os_codename" = "jammy" ]; then
    echo "--------------------------------"
    echo "....can install humble on it...."
    echo "--------------------------------"
else
    echo "--------------------------------"
    echo "....cannot install humble on this OS...."
    echo "--------------------------------"
    exit 1  # Exit the script with a status code of 1
fi

sleep 1

sudo apt install -y locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

export LANG=en_US.UTF-8

locale
echo "--------------------------------"
echo "....locales configs successful!...."
echo "--------------------------------"

sudo apt install -y software-properties-common
sudo add-apt-repository --yes universe


sudo apt update && sudo apt install curl -y

sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

sudo apt update

sudo apt install -y ros-humble-desktop

echo "--------------------------------"
echo "....ros successfully installed...."
echo "--------------------------------"

sleep 1

sudo apt install -y ros-dev-tools


ros_bashrc_line="source /opt/ros/humble/setup.bash"

if ! grep -qF "$ros_bashrc_line" /home/$USER/.bashrc ; then echo "$ros_bashrc_line" >> /home/$USER/.bashrc ; fi

tb3_bashrc_line="export TURTLEBOT3_MODEL=burger"

if ! grep -qF "$tb3_bashrc_line" /home/$USER/.bashrc ; then echo "$tb3_bashrc_line" >> /home/$USER/.bashrc ; fi

echo "--------------------------------"
echo "....ros env successfully set!...."
echo "--------------------------------"

sleep 1

echo 'if has("syntax")
	syntax on
endif

set hlsearch
set ts=4
set sts=4
set cindent
set laststatus=2
set shiftwidth=4
set showmatch
set smartcase
set smarttab
set smartindent
set ruler
set fileencodings=utf8,euc-kr' >> ~/.vimrc


if [ "${systemd-detect-virt}" = "vmware" ]; then
    echo "--------------------------------"
    echo "....can setup vmware environment...."
    echo "--------------------------------"
    sudo apt install -y open-vm-tools
fi