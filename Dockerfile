FROM nvidia/cuda:9.0-cudnn7-runtime AS cuda

RUN apt-get update

RUN apt-get install -y sudo\
                       wget\
                       lsb-release\
                       mesa-utils

# install ros
RUN echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list

RUN apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116

RUN apt-get update

RUN apt-get install -y ros-kinetic-desktop-full

# install gazebo8
RUN apt-get remove -y ros-kinetic-desktop-full

#RUN apt-get remove -y ros-kinetic-gazebo

RUN echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-latest.list \
         && wget http://packages.osrfoundation.org/gazebo.key -O - | apt-key add -

RUN apt-get update

RUN apt-get install -y libignition-math3\
                       libsdformat5\
                       libsdformat5-dev\
                       libgazebo8\
                       libgazebo8-dev\
                       gazebo8\
                       gazebo8-plugin-base\
                       ros-kinetic-gazebo8-ros-pkgs

RUN apt-get install -y ros-kinetic-gazebo8-ros-control\
                       ros-kinetic-ros-controllers\
                       ros-kinetic-ros-control

RUN apt-get install -y ros-kinetic-pcl*\
                       ros-kinetic-joy*

RUN apt-get upgrade -y

LABEL com.nvidia.volumes.needed="nvidia_driver"

ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}

ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}

# ros setting
RUN apt-get update

RUN apt-get install -y python\
                       python-pip\
                       python-empy\
                       git\
                       libpcl-dev

WORKDIR /root

RUN /bin/bash -c "mkdir -p catkin_ws/src"

RUN cd catkin_ws/src && /bin/bash -c "source /opt/ros/kinetic/setup.bash; catkin_init_workspace"

RUN cd catkin_ws && /bin/bash -c "source /opt/ros/kinetic/setup.bash; catkin_make"

RUN cd /root && echo source /root/catkin_ws/devel/setup.bash >> .bashrc

ENV ROS_PACKAGE_PATH=/root/catkin_ws:$ROS_PACKAGE_PATH

ENV ROS_WORKSPACE=/root/catkin_ws

## tensorflow
RUN pip install tensorflow-gpu==1.9.0\
                gym\
                keras

