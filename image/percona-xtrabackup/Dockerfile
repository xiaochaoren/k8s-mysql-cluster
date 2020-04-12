FROM ubuntu:18.04
MAINTAINER xiaochaoren
RUN rm -rf /etc/apt/sources.list

COPY sources.list /etc/apt/

RUN apt-get update
RUN apt-get install -y lsb-release
RUN apt-get install -y wget
RUN apt-get install -y gnupg
RUN apt-get install -y nmap

RUN wget -c https://repo.mysql.com/mysql-apt-config_0.8.14-1_all.deb
RUN export DEBIAN_FRONTEND=noninteractive && export DEBIAN_PRIORITY=critical && dpkg -i mysql-apt-config_0.8.14-1_all.deb

RUN wget https://repo.percona.com/apt/percona-release_latest.$(lsb_release -sc)_all.deb
RUN dpkg -i percona-release_latest.$(lsb_release -sc)_all.deb
RUN percona-release enable-only tools release
RUN apt-get update
RUN apt-get install -y mysql-client
RUN apt-get install -y percona-xtrabackup-80
RUN apt-get install -y mysql-shell

CMD ["/bin/bash"]
