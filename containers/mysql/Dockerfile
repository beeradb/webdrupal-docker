FROM webdrupal/fedora
MAINTAINER Brad Bowman <beeradb@gmail.com>

RUN groupadd -r mysql && useradd -r -g mysql mysql
RUN touch /var/log/mysqld.log
RUN chown mysql:root /var/log/mysqld.log

RUN yum -y install community-mysql-server community-mysql hostname && yum clean all

ADD start.sh /start.sh
RUN chmod -v +x /start.sh

ADD my.cnf /etc/my.cnf.d/my.cnf
RUN chmod o-w /etc/my.cnf.d/my.cnf

EXPOSE 3306
CMD ["/bin/bash", "/start.sh"]