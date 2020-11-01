FROM nimlang/nim:1.0.10-alpine-slim

MAINTAINER Taichi Uchihara <hoge.uchihara@gmail.com>

ENV \
  PATH="/root/.nimble/bin:${PATH}"

RUN \
  apk add --no-cache curl git && git clone https://github.com/nve3pd/trot ./trot && cd ./trot && nimble install -y 

ENTRYPOINT ["trot"]
