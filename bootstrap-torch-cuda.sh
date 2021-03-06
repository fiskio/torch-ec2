CUDA_DEB='http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/x86_64/cuda-repo-ubuntu1404_7.0-28_amd64.deb'
PIP='https://bootstrap.pypa.io/get-pip.py'

# Upgrade OS
sudo apt-get update
sudo apt-get -y upgrade

# Deps
sudo apt-get install -y sed
sudo apt-get install -y gnuplot
sudo apt-get install -y rsync
sudo apt-get install -y wget
sudo apt-get install -y libsdl2-dev
sudo apt-get install -y pv
sudo apt-get install -y libboost-dev libboost-iostreams-dev zlib1g-dev g++ pigz pv subversion

# AWS CLI
wget $PIP
sudo python `basename $PIP`
sudo pip install --upgrade awscli
rm `basename $PIP`
aws --version

# CUDA drivers
wget $CUDA_DEB
sudo dpkg -i `basename $CUDA_DEB`
sudo apt-get update
sudo apt-get install -y cuda
rm `basename $CUDA_DEB`
echo 'export PATH=/usr/local/cuda-7.0/bin:$PATH' >> ~/.bashrc # 7.0
echo 'export LD_LIBRARY_PATH=/usr/local/cuda-7.0/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc # 7.0

# FB extensions
#curl -sk https://raw.githubusercontent.com/facebook/fblualib/master/install_all.sh | sudo bash

# Torch Deps
curl -sk https://raw.githubusercontent.com/torch/ezinstall/master/install-deps | sudo bash
git clone https://github.com/torch/distro.git ~/torch-distro --recursive
cd ~/torch-distro;
./update.sh
./install.sh


# Torch + LuaJIT
#curl -sk https://raw.githubusercontent.com/torch/ezinstall/master/install-luajit+torch | sudo bash

# Torch Extras
luarocks install nngraph

# Torch CUDA
#luarocks install cutorch
#luarocks install cunn
luarocks install cunnx
#luarocks install cudnn

# Clean up
sudo apt-get clean

# Make local disk accessible
sudo chmod 777 /mnt

# Finally
source ~/.bashrc
th -e "print 'I just installed Torch! Yesss.'"

