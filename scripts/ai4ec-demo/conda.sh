#!/bin/bash

cd "$(dirname "$0")"
source common.sh

# download
[ -f "conda.done" ] || {
$SSH_CMD << SSH_EOF
set -e
[ -f "Miniconda3-latest-Linux-x86_64.sh" ] ||
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh -b -p ~/miniconda3
~/miniconda3/bin/conda init bash
SSH_EOF
touch conda.done
}
