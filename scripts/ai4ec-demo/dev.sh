#!/bin/bash
cd "$(dirname "$0")"
source common.sh

[ -f "ubuntu-dev.done" ] || {
$SSH_CMD << SSH_EOF
set -e
sudo apt update
sudo apt install -y build-essential
sudo apt install -y git

SSH_EOF
touch ubuntu-dev.done
}


[ -f "cuda.done" ] || {
$SSH_CMD << SSH_EOF
sudo apt install linux-headers-$(uname -r)

sudo apt-key del 7fa2af80
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb

sudo apt install -y cuda-drivers
sudo apt install -y cuda-toolkit

# don't forget to export PATH
export PATH=/usr/local/cuda-12/bin${PATH:+:${PATH}}

SSH_EOF
touch cuda.done
}



