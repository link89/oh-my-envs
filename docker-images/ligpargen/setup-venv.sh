#!/bin/bash

# create a virutalenv with apptainer
singularity exec ligpargen.sif bash <<EOF
set -e

python -mvenv --system-site-packages ./pyvenv/ai2-wmd
source ./pyvenv/ai2-wmd/bin/activate
cd ./src/ai2-wmd
pip install -e .

EOF
