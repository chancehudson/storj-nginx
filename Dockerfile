FROM jchancehud/libstorj:ubuntu-1.0.0
MAINTAINER Chance Hudson

RUN apt-get update && apt-get install -y nginx

# This kernel update addresses secure overlay network performance in docker networks
# Not sure if it needs to be applied on all levels, host and virtual, or not
# https://github.com/moby/moby/issues/33133

RUN mkdir -p /tmp/install && \
  cd /tmp/install && \
  wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.14.9/linux-headers-4.14.9-041409_4.14.9-041409.201712251541_all.deb && \
  wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.14.9/linux-headers-4.14.9-041409-generic_4.14.9-041409.201712251541_amd64.deb && \
  wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.14.9/linux-image-4.14.9-041409-generic_4.14.9-041409.201712251541_amd64.deb && \
  dpkg -i linux-headers-4.14.9-041409_4.14.9-041409.201712251541_all.deb && \
  dpkg -i linux-headers-4.14.9-041409-generic_4.14.9-041409.201712251541_amd64.deb && \
  dpkg -i linux-image-4.14.9-041409-generic_4.14.9-041409.201712251541_amd64.deb && \
  cd / && \
  rm -rf /tmp/install

COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
