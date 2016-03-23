#!/bin/sh

if [ ! -n "$1" ]; then
    echo "Please give the image folder as argument"
else
    xhost +
    docker run -it -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix:0 -v $1:/opt/workdir sfmmf
fi
