FROM percona/percona-server:8.0.18
MAINTAINER xiaochaoren

USER root

RUN yum install -y gnupg
COPY gosu-amd64 /usr/local/bin/gosu
COPY gosu-amd64.asc /usr/local/bin/gosu.asc
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && rm -r /root/.gnupg/ \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true

COPY entry.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["mysqld"]
