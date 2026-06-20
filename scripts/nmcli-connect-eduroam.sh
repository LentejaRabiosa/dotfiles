#!/bin/bash
# Heavily inspired by https://haluk.github.io/posts-output/2020-10-19-linux/

set -euo pipefail

read -rp "Wireless interface: " IFNAME
read -rp "Identity: " IDENTITY
read -rsp "Password: " PASSWORD
echo

nmcli connection delete eduroam >/dev/null 2>&1 || true

nmcli connection add \
    type wifi \
    ifname "$IFNAME" \
    con-name eduroam \
    ssid eduroam \
    ipv4.method auto \
    802-1x.eap peap \
    802-1x.phase2-auth mschapv2 \
    802-1x.identity "$IDENTITY" \
    802-1x.password "$PASSWORD" \
    wifi-sec.key-mgmt wpa-eap
