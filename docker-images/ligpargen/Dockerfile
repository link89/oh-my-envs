FROM python:3.10-slim
ENV BOSSdir=/opt/boss

WORKDIR /opt

COPY boss0615.tar.gz /opt/
RUN <<EOF
set -e
# Extract boss tarball and compile boss
echo "Extracting boss0615.tar.gz"
tar -xzvf boss0615.tar.gz
EOF

RUN <<EOF
set -e
env | grep -i proxy
dpkg --add-architecture i386
apt-get update
apt-get install -y libc6:i386 libstdc++6:i386
apt-get install -y git csh openbabel libopenbabel-dev build-essential 
apt-get clean && rm -rf /var/lib/apt/lists/*
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
