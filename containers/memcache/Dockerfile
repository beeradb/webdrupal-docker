FROM webdrupal/base
MAINTAINER Brad Bowman <beeradb@gmail.com>

RUN yum install -y memcached

EXPOSE 11211

USER daemon

CMD ["-m", "64"]

ENTRYPOINT memcached