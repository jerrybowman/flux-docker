#!/bin/bash

FLUX_VERSION=8-0-13

SYSTEM=$(uname -m)

echo $SYSTEM

case $SYSTEM in
    x86_64)
       TAG_SUFFIX=amd64-linux
       ;;
    arm*)
       TAG_SUFFIX=arm-linux
       ;;
    *)
       echo "unknown architecture $SYSTEM"
       exit 1
esac
echo "Building image: " flux-$TAG_SUFFIX:${FLUX_VERSION}

docker build -t flux-$TAG_SUFFIX:latest --build-arg flux_version=${FLUX_VERSION} .
docker tag flux-$TAG_SUFFIX:latest flux-$TAG_SUFFIX:${FLUX_VERSION} 

