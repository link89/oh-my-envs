#!/bin/bash
cd "$(dirname "$0")"

docker build --progress plain -t comp-chem . --build-arg HTTP_PROXY=$HTTP_PROXY --build-arg HTTPS_PROXY=$HTTPS_PROXY

