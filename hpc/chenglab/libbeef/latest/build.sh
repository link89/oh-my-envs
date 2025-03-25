#!/bin/bash
set -e

# download source code
[ -f download.done ] || {
git clone https://github.com/vossjo/libbeef

touch download.done
}

cd ./libbeef

# build and install
[ -f build.done ] || {
module purge
module add compiler/2022.0.1
./configure CC=icc --prefix=/data/share/lib/libbeef/latest --enable-optmax
make
sudo make install

touch build.done
}

# create module file
sudo mkdir -p /data/share/base/modulefiles/chem/libbeef
cat <<EOF | sudo tee /data/share/base/modulefiles/chem/libbeef/latest
#%Module1.0
module-whatis "Loads libbeef library (version: latest)"
set root /data/share/lib/libbeef/latest
prepend-path PATH \$root/bin
prepend-path LIBRARY_PATH \$root/lib
prepend-path LD_LIBRARY_PATH \$root/lib
setenv LIBBEEF_HOME \$root
EOF