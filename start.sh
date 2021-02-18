#!/bin/ash

# docker run -e PSK=<custom_psk> -p<host_port>:2021 --restart always -d vyron/snell-server:latest

BIN="/usr/bin/snell-server"
CONF="/etc/snell-server.conf"

# reuse existing config when the container restarts

start() {
    echo "Snell-server is running with config:"
    cat ${CONF}

    ${BIN} --version
    ${BIN} -c ${CONF}
}

if [ -f ${CONF} ]; then
    echo "Configuration file already exists and will be deleted"
    rm ${CONF}
fi

if [ -z ${PSK} ]; then
    echo "PSK is not specified, automatically generated"
    PSK=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 16)
    echo "The automatically generated PSK is ${PSK}"
else
    echo "Use specified PSK: ${PSK}"
fi

if [ -z ${OBFS} ]; then
    OBFS=tls
    echo "OBFS is not specified, the default is tls"
fi

echo "Generating new config..."
echo "[snell-server]" >> ${CONF}
echo "listen = 0.0.0.0:${PORT}" >> ${CONF}
echo "psk = ${PSK}" >> ${CONF}
echo "obfs = ${OBFS}" >> ${CONF}

start