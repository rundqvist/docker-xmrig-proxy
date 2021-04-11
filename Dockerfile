FROM ubuntu:18.04

LABEL maintainer="mattias.rundqvist@icloud.com"

WORKDIR /app

RUN apt update 
RUN apt -y install git build-essential cmake libuv1-dev uuid-dev libmicrohttpd-dev libssl-dev
RUN mkdir -p /tmp/xmrig-proxy

RUN git clone https://github.com/xmrig/xmrig-proxy.git /tmp/xmrig-proxy

RUN mkdir -p /tmp/xmrig-proxy/build

RUN cd /tmp/xmrig-proxy/build && cmake ..
RUN cd /tmp/xmrig-proxy/build && make -j$(nproc)

RUN mv /tmp/xmrig-proxy/build/xmrig-proxy /usr/sbin/ \
    && rm -rf /tmp/xmrig-proxy

ENTRYPOINT [ "/bin/sh", "-c", "xmrig-proxy -c /config/config.json" ]
