FROM ubuntu:20.04

COPY entrypoint.sh /entrypoint.sh

RUN apk add envsubst

ENTRYPOINT ["/entrypoint.sh"]
