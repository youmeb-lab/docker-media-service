FROM node:0.11.14
MAINTAINER Po-Ying Chen <poying.me@gmail.com>

RUN apt-get update \
  && apt-get install -y \
  curl lsb-release libgsf-1-dev unzip

RUN curl -s https://raw.githubusercontent.com/lovell/sharp/master/preinstall.sh | bash
RUN rm -rf /var/lib/apt/lists/*
RUN curl -LOk https://github.com/youmeb-lab/media-service/archive/master.zip \
  && unzip master.zip \
  && rm master.zip \
  && mv ./media-service-master /app \
  && cd /app \
  && npm i \
  && mkdir tmp log medias

WORKDIR /app

ENV TMPDIR /app/tmp
EXPOSE 80

CMD ["node", "--harmony", "app", "--config", "./config.default"]
