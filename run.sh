if [ ! -n "$1" ]; then
    echo "Please give the image folder as argument"
else
    docker run -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY --device /dev/dri -v $1:/opt/workdir sfmmf
fi
