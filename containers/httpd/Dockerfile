FROM fedora:21
MAINTAINER Brad Bowman <beeradb@gmail.com>

RUN yum -y update && yum clean all

RUN rpm -Uvh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-stable.noarch.rpm
RUN rpm -Uvh http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-stable.noarch.rpm
RUN rpm -Uvh http://rpms.famillecollet.com/remi-release-21.rpm
RUN yum remove php php-cgi php-cli php-common

RUN yum install -y curl httpd
RUN yum --enablerepo=remi,remi-55-php55 -y install php php-common php-xdebug

EXPOSE 80

ADD run-apache.sh /run-apache.sh
RUN chmod -v +x /run-apache.sh
ADD ./vhosts.conf /etc/httpd/conf.d/vhosts.conf

CMD ["/run-apache.sh"]