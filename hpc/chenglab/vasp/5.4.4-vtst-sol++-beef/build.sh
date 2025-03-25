
#!/bin/bash
set -e

# setup vasp 5.4.4, vaspsol, vtst, etc according to the official document

# build and install
[ -f build.done ] || {

module purge
module add compiler/2022.0.1 mkl/2022.0.1 mpi/2021.5.0
module add cuda/11.8
module add libbeef/latest
make

touch build.done
}