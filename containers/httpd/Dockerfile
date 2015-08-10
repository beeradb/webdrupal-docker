FROM webdrupal/base
MAINTAINER Brad Bowman <beeradb@gmail.com>

RUN yum install -y curl httpd
RUN yum -y install php php-common php-xdebug php-pecl-apc && yum clean all
RUN yum -y install php-pdo php-mcrypt php-gd php-mysql php-pecl-memcache && yum clean all

ADD conf/php.ini /etc/php.ini
ADD run-apache.sh /run-apache.sh
RUN chmod -v +x /run-apache.sh
ADD conf/vhosts.conf /etc/httpd/conf.d/vhosts.conf
ADD conf/httpd.conf /etc/httpd/conf/httpd.conf

EXPOSE 80
EXPOSE 81

CMD ["/run-apache.sh"]
