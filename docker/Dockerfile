# This is an auto generated Dockerfile for ros:ros-core
# generated from docker_images/create_ros_core_image.Dockerfile.em
FROM ubuntu:bionic-20200807

# setup timezone
RUN echo 'Etc/UTC' > /etc/timezone && \
    ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    apt-get update && \
    apt-get install -q -y --no-install-recommends tzdata && \
    rm -rf /var/lib/apt/lists/*

# allow nvidia container toolkit
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics,compute,utility,display


RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
      apt-get -y install sudo


RUN DEBIAN_FRONTEND=noninteractive apt-get -y install libboost-filesystem-dev libboost-system-dev libboost-thread-dev terminator vim libjsoncpp-dev gimp vlc jstest-gtk openssh-server lm-sensors htop tmux xclip nano vim python-tk dbus-x11 python3-pip python-pip 

# install packages
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -q -y --no-install-recommends \
    dirmngr \
    gnupg2 

# Install sublime
RUN curl -O https://download.sublimetext.com/sublime-text_build-"${SUBLIME_BUILD}"_amd64.deb && \
        dpkg -i -R sublime-text_build-"${SUBLIME_BUILD}"_amd64.deb || echo "\n Will force install of missing ST3 dependencies...\n" 
        
# Force installation of missing dependencies for Sublime
RUN DEBIAN_FRONTEND=noninteractive apt-get -y -f install && \
        rm -rvf sublime-text_build-"${SUBLIME_BUILD}"_amd64.deb && \
        rm -rf /var/lib/apt/lists/*
     
# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

# setup sources.list
RUN echo "deb http://packages.ros.org/ros/ubuntu bionic main" > /etc/apt/sources.list.d/ros1-latest.list

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

ENV ROS_DISTRO melodic

# install ros packages
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y --no-install-recommends \
    ros-melodic-desktop-full=1.4.1-0* \
    && rm -rf /var/lib/apt/lists/*

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install --no-install-recommends -y \
    build-essential \
    python-rosdep \
    python-rosinstall \
    python-vcstools \
    && rm -rf /var/lib/apt/lists/*

RUN rosdep init && rosdep update --rosdistro $ROS_DISTRO
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install -y python-rosinstall ros-melodic-qt-ros
RUN pip install -U catkin_tools

###########################

# Terminator Config
RUN mkdir -p /root/.config/terminator/
COPY docker/terminator_config /root/.config/terminator/config 
		
# setup entrypoint
COPY docker/bashrc /root/.bashrc
COPY docker/ros_entrypoint.sh /
ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
SHELL ["/bin/bash", "-c"]
CMD /bin/bash -c "source ~/.bashrc"
