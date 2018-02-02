FROM jchancehud/libstorj:ubuntu-1.0.0
MAINTAINER Chance Hudson

RUN apt-get update && apt-get install -y nginx

COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
