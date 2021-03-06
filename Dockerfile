FROM frolvlad/alpine-glibc

ARG SENLL_VERSION=v2.0.3

LABEL maintainer="vyron"

ENV LANG=C.UTF-8 \
    PORT=2021 \
    PSK= \
    OBFS=tls \
    REBUILD=off

COPY start.sh /usr/bin/

RUN apk update && \
    apk upgrade && \
    apk add --no-cache libstdc++

RUN wget --no-check-certificate -O snell.zip https://github.com/surge-networks/snell/releases/download/$SENLL_VERSION/snell-server-$SENLL_VERSION-linux-amd64.zip && \
    unzip snell.zip && \
    rm -f snell.zip && \
    chmod +x snell-server && \
    mv snell-server /usr/bin/ && \
    chmod +x /usr/bin/start.sh

EXPOSE $PORT

ENTRYPOINT ["start.sh"]