#!/bin/bash

DOCKER_COMPOSE='/usr/local/bin/docker-compose'
COMPOSE_FILE='/usr/local/containers/docker-compose.yml'
ALL_CONTAINERS='sudo docker ps -a -q'
MYSQL='mysql -uroot -proot -h127.0.0.1 '
WEBDRUPAL_IMPORT_DB='/usr/share/conf/webdrupal.sql'

sudo yum -y install docker bash-completion hostname community-mysql

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
sudo systemctl start docker.service

# Kill any currently running containers.
if [[ -n $($ALL_CONTAINERS) ]] ; then
  sudo docker rm -f $($ALL_CONTAINERS)
fi

# Build the base image.
sudo docker build -t="webdrupal/fedora" /usr/local/containers/fedora

# Initialize containers
$DOCKER_COMPOSE --verbose -f $COMPOSE_FILE up -d

# sleep briefly to let the containers fully initialize before continuing.
sleep 5s

# If needed, import DB.
if [ ! -d /var/lib/mysql/webdrupaldb ] ; then
  if [ ! -f $WEBDRUPAL_IMPORT_DB ] ; then
    printf "The database has not been initialized and no import file can be found."
  else
    echo "create database webdrupaldb" | $MYSQL
    $MYSQL webdrupaldb < $WEBDRUPAL_IMPORT_DB
  fi
fi

# If needed, link settings file.
if [ ! -f /usr/share/webdrupal/html/sites/default/settings.php ] ; then
  if [ ! -f /usr/share/conf/settings.php ] ; then
    printf "No settings file found. The symlink has not been created."
  else
    # This is kind of crappy but I want to keep it as a relative link so it works outside
    # of the container / vagrant.
    ln -s ../../../../conf/settings.php /usr/share/webdrupal/html/sites/default/settings.php
  fi
fi