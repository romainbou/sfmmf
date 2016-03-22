#!/bin/sh

# Build the docker image build all required libraries
docker build -t sfmmf-builder docker-build/

# Built binaries to the bin folder
docker run -v bin:/opt/hostbin sfmmf-builder

# Build the docker image to run the script
docker build -t sfmmf .
