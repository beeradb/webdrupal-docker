FROM webdrupal/base
MAINTAINER Brad Bowman <beeradb@gmail.com>

RUN yum install -y haproxy && yum clean all

EXPOSE 80

ADD haproxy.conf /etc/haproxy.conf

CMD ["haproxy", "-f", "/etc/haproxy.conf"]