FROM percona-xtrabackup:8.0
LABEL maintainer="xiaochaoren"
RUN apt-get purge -y percona-xtrabackup-80
RUN apt-get install -y mysql-router

EXPOSE 646
EXPOSE 6447

CMD ["bash", "-c", "tail -f /dev/null"]