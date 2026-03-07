#!/usr/bin/env bash

PROXY_HOST="127.0.0.1"
PROXY_PORT="10808"
PROXY="socks5://$PROXY_HOST:$PROXY_PORT"

set_proxy() {
    export http_proxy=$PROXY
    export https_proxy=$PROXY
    export ftp_proxy=$PROXY
    export all_proxy=$PROXY

    export HTTP_PROXY=$PROXY
    export HTTPS_PROXY=$PROXY
    export FTP_PROXY=$PROXY
    export ALL_PROXY=$PROXY

    echo "Proxy set to $PROXY"
}

clear_proxy() {
    unset http_proxy
    unset https_proxy
    unset ftp_proxy
    unset all_proxy

    unset HTTP_PROXY
    unset HTTPS_PROXY
    unset FTP_PROXY
    unset ALL_PROXY

    echo "Proxy cleared"
}

case "$1" in
    set)
        set_proxy
        ;;
    clear)
        clear_proxy
        ;;
    *)
        echo "Usage:"
        echo "  source pyproxy.sh set"
        echo "  source pyproxy.sh clear"
        ;;
esac