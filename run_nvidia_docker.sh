#!/bin/bash

if [ $# -ne 1 ]; then
  exit 1
fi

nvidia-docker run -it --rm \
  --runtime=nvidia \
  -e NVIDIA_VISIBLE_DEVICES=0,1 \
  --env=QT_X11_NO_MITSHM=1 \
  --env=DISPLAY=$DISPLAY \
  --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
  $1
  #$(for i in $(id -G); do echo -n "--group-add "$i; done) \
  #--env=LD_LIBRARY_PATH=$LD_LIBRARY_PATH \
  #--user=$(id -u):$(id -g) \
  #--workdir="/home/$USER" \
  #--volume="/home/$USER:/home/$USER" \
  #--volume="/etc/group:/etc/group:ro" \
  #--volume="/etc/passwd:/etc/passwd:ro" \
  #--volume="/etc/shadow:/etc/shadow:ro" \
  #--volume="/etc/sudoers.d:/etc/sudoers.d:ro" \
