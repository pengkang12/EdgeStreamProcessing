FROM storm-base:latest

MAINTAINER peng kang<peng.kang@utsa.edu>

ADD start.sh /

EXPOSE 3772 6627 

WORKDIR /home/cc/storm

ADD riot-bench /home/cc/storm/riot-bench

ENTRYPOINT ["/start.sh"]
