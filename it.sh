#!/bin/sh

if [ ! -n "$1" ]; then
    echo "Please give the image folder as argument"
else
    docker run -it -u $(id -u):$(id -g) -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY -v $1:/opt/workdir sfmmf
fi
