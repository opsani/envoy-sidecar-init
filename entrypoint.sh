#!/usr/bin/env bash

set -e

if [ -z "$ENVOY_PORT" ]; then
    echo "ENVOY_PORT is missing" >&2
    exit 1
fi

# Configure bypasses in EXCLUDE_PORTS
if [ ! -z "$EXCLUDE_PORTS" ]; then
    for port in $EXCLUDE_PORTS; do
        iptables -t nat -A PREROUTING -p tcp --dport $port -j ACCEPT
    done
fi

# Redirect specified in $PROXY_PORTS
if [ ! -z "$PROXY_PORTS" ]; then
    for port in $PROXY_PORTS; do
        iptables -t nat -A PREROUTING -p tcp --dport $port -j REDIRECT --to-port ${ENVOY_PORT}
    done
else
    # Redirect all inbound traffic to Envoy
    iptables -t nat -A PREROUTING -p tcp -j REDIRECT --to-port ${ENVOY_PORT}
fi

exit 0

