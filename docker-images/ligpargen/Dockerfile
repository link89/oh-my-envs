FROM python:3.10-slim
ENV BOSSdir=/opt/boss
ENV PACKMOL=/opt/packmol-20.16.0
ENV PATH=$PATH:$BOSSdir:$PACKMOL

WORKDIR /opt


RUN <<EOF
set -e
env | grep -i proxy
dpkg --add-architecture i386
apt-get update
apt-get install -y libc6:i386 libstdc++6:i386
apt-get install -y git csh openbabel libopenbabel-dev build-essential gfortran

apt-get clean && rm -rf /var/lib/apt/lists/*
EOF


RUN --mount=type=bind,target=/mnt/data <<EOF
set -e
# Extract boss tarball
tar -xzvf /mnt/data/boss0615.tar.gz

# Extract packmol tarball and compile
echo $PATH
tar -xzvf /mnt/data/packmol-20.16.0.tar.gz
cd packmol-20.16.0
./configure
make
EOF


RUN <<EOF
set -e
# pip install the required packages
git clone --depth 1 https://github.com/Isra3l/ligpargen.git
cd ligpargen
sed -i 's/3.7/3.10/' setup.py
git diff
dpkg -L libopenbabel-dev
ln -s /usr/include/openbabel3 /usr/local/include/openbabel3
pip install --no-cache-dir swig
pip install --no-cache-dir rdkit openbabel
pip install --no-cache-dir -e .
EOF


CMD [ "python3", "--version" ]
