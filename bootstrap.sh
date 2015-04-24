#!/bin/bash

sudo yum -y install docker bash-completion hostname

# Install docker-compose
curl -L https://github.com/docker/compose/releases/download/1.2.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

mkdir -p /var/lib/mysql

sudo systemctl start docker.service
sudo docker rm -f $(sudo docker ps -a -q)

cd /usr/local/containers
/usr/local/bin/docker-compose up


#sudo docker build -t="webdrupal/mysql" /usr/local/containers/mysql
#sudo docker run -d --name mysql -P webdrupal/mysql

#sudo docker build -t="webdrupal/httpd" /usr/local/containers/httpd
#sudo docker run -d -v /usr/share/webdrupal:/usr/share/webdrupal -p 80:80 --name httpd -P webdrupal/httpd