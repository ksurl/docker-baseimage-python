FROM        python:3.9-alpine

LABEL       org.opencontainers.image.source="https://github.com/ksurl/docker-baseimage-python"

LABEL       maintainer="ksurl"

ARG         S6_VERSION

ENV         TZ="UTC"

RUN         echo "**** install build packages ****" && \
            apk add --no-cache --virtual=build-dependencies \
                curl \
                tar && \
            echo "**** install s6-overlay" && \
            if [ -z ${S6_VERSION} ]; then \
                S6_VERSION=$(curl -sX GET "https://api.github.com/repos/just-containers/s6-overlay/releases/latest" \
                | grep "tag_name" \
                | sed -e 's/.*v//' -e 's/",//'); \
            fi && \
            curl -o /tmp/install_s6 -fsSL https://github.com/just-containers/s6-overlay/releases/download/v${S6_VERSION}/s6-overlay-amd64-installer && \
            chmod +x /tmp/install_s6 && \
            /tmp/install_s6 / && \
            echo "**** install packages ****" && \
            apk add --no-cache \
                bash \
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
            apk del --purge build-dependencies && \
            rm -rf /tmp/* /var/cache/apk/*

COPY        root/ /

ENTRYPOINT  [ "/init" ]
