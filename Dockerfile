FROM osrf/ros:kinetic-desktop

RUN apt-get update

RUN apt-get install -y sudo\
                       wget\
                       lsb-release\
                       mesa-utils

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

RUN apt-get upgrade -y

#nvidia environment
LABEL com.nvidia.volumes.needed="nvidia_driver"

ENV PATH /usr/local/nvidia/bin:${PATH}

ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}

#ros setting
RUN mkdir -p ros_catkin_ws/src

RUN cd ros_catkin_ws/src && /bin/bash -c "source /opt/ros/kinetic/setup.bash; catkin_init_workspace"

RUN cd ros_catkin_ws && /bin/bash -c "source /opt/ros/kinetic/setup.bash; catkin_make"

RUN cd /root && echo source ros_catkin_ws/devel/setup.bash >> .bashrc

ENV ROS_PACKAGE_PATH=/ros_catkin_ws:$ROS_PACKAGE_PATH

ENV ROS_WORKSPACE=/ros_catkin_ws
