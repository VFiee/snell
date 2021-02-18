#!/bin/ash

# docker run -e PSK=<custom_psk> -p<host_port>:2021 --restart always -d vyron/snell-server:latest

BIN="~/usr/bin/snell-server"
CONF="~/etc/snell-server.conf"

# reuse existing config when the container restarts

# clear console
clear

start() {
    echo -e "[Snell Info]: Snell-server is running with config:"
    cat ${CONF}

    ${BIN} --version
    ${BIN} -c ${CONF}
}

buildConfig() {
    if [ -z ${PSK} ]; then
        echo -e "[Snell Info]: PSK is not specified, automatically generated \n"
        PSK=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 16)
        echo -e "[Snell Info]: The automatically generated PSK is ${PSK} \n"
    else
        echo -e "[Snell Info]: Use specified PSK: ${PSK} \n"
    fi

    if [ -z ${OBFS} ]; then
        OBFS=tls
        echo -e "[Snell Info]: OBFS is not specified, the default is tls \n"
    fi

    echo -e "Generating new config... \n"
    echo "[snell-server]" >> ${CONF}
    echo "listen = 0.0.0.0:${PORT}" >> ${CONF}
    echo "psk = ${PSK}" >> ${CONF}
    echo "obfs = ${OBFS}" >> ${CONF}
}

if [ -f ${CONF} ]; then
    echo -e "[Snell Info]: Configuration file already exists and will be reuse \n"
else
    buildConfig
fi

start