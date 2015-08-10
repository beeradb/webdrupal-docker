#!/bin/bash

DOCKER_COMPOSE='/usr/local/bin/docker-compose'
COMPOSE_FILE='/usr/local/containers/docker-compose.yml'
ALL_CONTAINERS='sudo docker ps -a -q'
MYSQL='mysql -uroot -proot -h127.0.0.1 --max_allowed_packet=512M '
#WEBDRUPAL_IMPORT_DB=''

sudo apt-get update
sudo apt-get -y install bash-completion hostname mysql-client linux-image-extra-`uname -r`

if [ ! -f  /usr/local/bin/docker ]; then
  sudo apt-get install wget
  sudo wget -qO- https://get.docker.com/ | sudo sh
  sudo ln -sf /usr/bin/docker.io /usr/local/bin/docker
fi

#sudo sed -i '$acomplete -F _docker docker' /etc/bash_completion.d/docker.io
#sudo echo -e 'OPTIONS=--selinux-enabled --dns 8.8.8.8 --dns 8.8.4.4' | sudo tee -a /etc/sysconfig/docker

# Install docker-compose.
if [ ! -f  $DOCKER_COMPOSE ]; then
  curl -L https://github.com/docker/compose/releases/download/1.2.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
  chmod +x $DOCKER_COMPOSE
fi

# Initialize mysql data directory, since the mysql container mounts this directory.
# @todo: Move this (and other shared mounts) to it's own data container?
mkdir -p /var/lib/mysql
chmod ugo+wr /var/lib/mysql

# Ensure docker is started.
sudo service docker restart

# Kill any currently running containers.
if [[ -n $($ALL_CONTAINERS) ]] ; then
  sudo docker rm -f $($ALL_CONTAINERS)
fi

# Build the base image.
sudo docker build -t="webdrupal/base" /usr/local/containers/base

# Initialize containers
$DOCKER_COMPOSE -f $COMPOSE_FILE up -d

# sleep briefly to let the containers fully initialize before continuing.
sleep 15s

# If needed, import DB.
#if [ ! -d /var/lib/mysql/webdrupaldb ] ; then
#  if [ ! -f $WEBDRUPAL_IMPORT_DB ] ; then
#    printf "The database has not been initialized and no import file can be found."
#  else
#    echo "create database webdrupaldb" | $MYSQL
#    $MYSQL webdrupaldb < $WEBDRUPAL_IMPORT_DB
#  fi
# fi
