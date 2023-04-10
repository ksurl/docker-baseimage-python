FROM        python:3.11.3-alpine3.17

LABEL       org.opencontainers.image.source="https://github.com/ksurl/docker-baseimage-python"

LABEL       maintainer="ksurl"

ENV         TZ="UTC"

RUN         echo "**** install packages ****" && \
            apk add --no-cache \
                bash \
                s6-overlay \
                shadow \
                tzdata && \
            echo "**** create user ****" && \
            groupmod -g 1000 users && \
            useradd -u 911 -U -d /config -s /bin/false abc && \
            usermod -G users abc && \
            mkdir -p /config && \
            echo "**** disable root login ****" && \
            sed -i -e 's/^root::/root:!:/' /etc/shadow && \
            echo "**** cleanup ****" && \
            rm -rf /tmp/* /var/cache/apk/*

COPY        root/ /

ENTRYPOINT  [ "/init" ]
