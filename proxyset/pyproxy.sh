#!/usr/bin/env bash

BASHRC="$HOME/.bashrc"

PROXY_HOST="127.0.0.1"
PROXY_PORT="10808"
PROXY="socks5://$PROXY_HOST:$PROXY_PORT"

START_MARK="# >>> pyproxy start >>>"
END_MARK="# <<< pyproxy end <<<"

set_current() {
    export http_proxy="$PROXY"
    export https_proxy="$PROXY"
    export ftp_proxy="$PROXY"
    export all_proxy="$PROXY"

    export HTTP_PROXY="$PROXY"
    export HTTPS_PROXY="$PROXY"
    export FTP_PROXY="$PROXY"
    export ALL_PROXY="$PROXY"

    echo "Proxy set for current terminal: $PROXY"
}

clear_current() {
    unset http_proxy https_proxy ftp_proxy all_proxy
    unset HTTP_PROXY HTTPS_PROXY FTP_PROXY ALL_PROXY

    echo "Proxy cleared for current terminal"
}

set_global() {

    if grep -q "$START_MARK" "$BASHRC"; then
        echo "Proxy already configured in .bashrc"
        return
    fi

    cat >> "$BASHRC" <<EOF

$START_MARK
export http_proxy="$PROXY"
export https_proxy="$PROXY"
export ftp_proxy="$PROXY"
export all_proxy="$PROXY"

export HTTP_PROXY="$PROXY"
export HTTPS_PROXY="$PROXY"
export FTP_PROXY="$PROXY"
export ALL_PROXY="$PROXY"
$END_MARK

EOF

    echo "Proxy added to .bashrc"

    source "$BASHRC"

    echo "Proxy applied globally"
}

clear_global() {

    if ! grep -q "$START_MARK" "$BASHRC"; then
        echo "Proxy not found in .bashrc"
        return
    fi

    sed -i "/$START_MARK/,/$END_MARK/d" "$BASHRC"

    echo "Proxy removed from .bashrc"

    source "$BASHRC"

    echo "Proxy cleared globally"
}

MODE="global"

if [[ "$2" == "--this" ]]; then
    MODE="current"
fi

case "$1" in
    set)
        if [[ "$MODE" == "current" ]]; then
            set_current
        else
            set_global
        fi
        ;;
    clear)
        if [[ "$MODE" == "current" ]]; then
            clear_current
        else
            clear_global
        fi
        ;;
    *)
        echo "Usage:"
        echo "  ./pyproxy.sh set            # proxy all terminals"
        echo "  ./pyproxy.sh clear"
        echo ""
        echo "  source pyproxy.sh set --this   # only current terminal"
        echo "  source pyproxy.sh clear --this"
        ;;
esac
