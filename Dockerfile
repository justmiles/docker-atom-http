# Builds a docker gui image https://github.com/linuxserver/dockergui
FROM hurricane/dockergui:xvnc

#########################################
##        ENVIRONMENTAL CONFIG         ##
#########################################

# Set environment variables
# Custom packages to install
ENV APM_PACKAGES="" 

# User/Group Id gui app will be executed as default are 99 and 100
ENV USER_ID=1000
ENV GROUP_ID=1000

# Gui App Name default is "GUI_APPLICATION"
ENV APP_NAME="atom"

# Default resolution, change if you like
ENV WIDTH=1920
ENV HEIGHT=960

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Install app dependencies
RUN \
  echo 'deb http://archive.ubuntu.com/ubuntu trusty main universe restricted' > /etc/apt/sources.list && \
  echo 'deb http://archive.ubuntu.com/ubuntu trusty-updates main universe restricted' >> /etc/apt/sources.list && \
  apt-get update && \ 
  apt-get install -y git gconf2 gconf-service libnotify4 gvfs-bin xdg-utils libxss1 gnome-terminal && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*
  
RUN URL='https://atom.io/download/deb' && \
  FILE=`mktemp` && \
  wget "$URL" -qO $FILE && \
  dpkg -i $FILE && \
  rm -rf $FILE && \
  
  # https://github.com/atom/atom/issues/4360
  find /usr/lib -type f -name "libxcb.so.1*" -exec cp {} /usr/share/atom/libxcb.so.1 \; && \
  sed -i 's/BIG-REQUESTS/_IG-REQUESTS/' /usr/share/atom/libxcb.so.1

COPY files/firstrun.sh /etc/my_init.d/firstrun.sh
COPY files/startapp.sh /startapp.sh
RUN chmod +x /etc/my_init.d/firstrun.sh

VOLUME /.atom
VOLUME /workspace

EXPOSE 8080
