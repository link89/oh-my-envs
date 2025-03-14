#!/bin/bash
set -e
cd "$(dirname "$0")"

apptainer build ligpargen.sif docker-daemon://ligpargen:latest
