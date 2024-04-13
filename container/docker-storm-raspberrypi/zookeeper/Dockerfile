FROM ubuntu:20.04

RUN apt-get update  && apt-get install -y --no-install-recommends apt-utils

RUN apt-get install openjdk-8-jre-headless -y

ENV HOME="/" \
    PATH="/opt/scripts:/opt/zookeeper/bin:$PATH"

ADD zookeeper /opt/zookeeper

COPY scripts /opt

RUN chmod g+rwX /opt
RUN find /opt -perm /6000 -type f -exec chmod a-s {} \; || true

EXPOSE 2181

WORKDIR /

USER 1001

ENTRYPOINT ["/opt/entrypoint.sh"]
CMD ["/opt/run.sh"]
