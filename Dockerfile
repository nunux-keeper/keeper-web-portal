# Nunux Keeper web portal.
#
# VERSION 1.0

FROM alpine:latest

MAINTAINER Nicolas Carlier <https://github.com/ncarlier>

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ENV HUGO_VERSION=0.20.7
RUN apk add --update wget ca-certificates && \
      cd /tmp/ && \
      wget https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz && \
      tar xzf hugo_${HUGO_VERSION}_Linux-64bit.tar.gz && \
      rm -r hugo_${HUGO_VERSION}_Linux-64bit.tar.gz && \
      mv hugo /usr/bin/hugo && \
      apk del wget ca-certificates && \
      rm /var/cache/apk/*

COPY . /usr/src/app

EXPOSE 1313

CMD [ "hugo", "server", "--bind", "0.0.0.0", "-D" ]

