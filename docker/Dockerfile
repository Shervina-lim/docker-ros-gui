ARG ros_distro
# ARG user_name
FROM osrf/ros:${ros_distro}-desktop-full

RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get -yq --allow-downgrades --allow-remove-essential --allow-change-held-packages install \
		sudo \
		python-catkin-tools \
		dialog \
		less \
		x-window-system \
		mesa-utils \
		apt-transport-https \
		ca-certificates \
		curl \
		software-properties-common \
		python3-pip 

# create user
RUN mkdir -p /home/ros
#copy bash file
COPY docker/cp-bashrc /home/ros/.bashrc

# install sublime
RUN curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
RUN add-apt-repository "deb https://download.sublimetext.com/ apt/stable/"
RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get -yq --force-yes install \
		sublime-text

ENTRYPOINT ["bin/bash"]
