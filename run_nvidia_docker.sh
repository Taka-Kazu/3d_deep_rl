#!/bin/bash

echo "=== run_nvidia_docker ==="

devs=""

for dev in ${@:2:($#-1)}
do
  devs=$devs,$dev
done

devs=${devs#,}

echo "Using GPUs:"$devs

read -e -p "Enter docker options:" OPTIONS

OPTIONS="$(eval "echo $OPTIONS")"

echo $OPTIONS

read -e -p "Enter command:" COMMAND

xhost +local:docker

NV_GPU=$devs nvidia-docker run -it --rm \
  --env=QT_X11_NO_MITSHM=1 \
  --env=DISPLAY=$DISPLAY \
  --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
  $OPTIONS \
  $1 $COMMAND
