FROM mysql:8.0.34-debian

RUN apt-get autoclean \
    && apt-get clean all \
    && apt-get update \
    && apt-get install -y wget vim \
    && apt-get clean \
    && ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

EXPOSE 3306
