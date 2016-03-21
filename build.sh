#!/bin/sh

docker build -t sfmmf-builder docker-build/

docker run -it -v ./bin:/opt/bin sfmmf-builder
