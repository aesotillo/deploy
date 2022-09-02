FROM ubuntu:20.04

COPY entrypoint.sh /entrypoint.sh

RUN apt update && apt install -y envsubst git gettext libintl

ENTRYPOINT ["/entrypoint.sh"]
