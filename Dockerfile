# Nunux Keeper web portal.
#
# VERSION 1.0

FROM alpine:latest

MAINTAINER Nicolas Carlier <https://github.com/ncarlier>

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ENV HUGO_VERSION=0.18.1
RUN apk add --update wget ca-certificates && \
      cd /tmp/ && \
      wget https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz && \
      tar xzf hugo_${HUGO_VERSION}_Linux-64bit.tar.gz && \
      rm -r hugo_${HUGO_VERSION}_Linux-64bit.tar.gz && \
      mv hugo*/hugo* /usr/bin/hugo && \
      apk del wget ca-certificates && \
      rm /var/cache/apk/*

ONBUILD COPY . /usr/src/app

EXPOSE 1313

CMD [ "hugo", "server" ]

