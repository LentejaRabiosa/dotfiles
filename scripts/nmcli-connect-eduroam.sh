#!/bin/bash
# Heavily inspired by https://haluk.github.io/posts-output/2020-10-19-linux/

# Replace <IFNAME> with wifi device name
# Replace <IDENTITY> with student identity (i.e. <USERNAME>@ntnu.no)
# Replace <PASSWORD> with user password
nmcli con add \
  type wifi \
  ifname <IFNAME> \
  con-name eduroam \
  ssid eduroam \
  ipv4.method auto \
  802-1x.eap peap \
  802-1x.phase2-auth mschapv2 \
  802-1x.identity <IDENTITY> \
  802-1x.password <PASSWORD> \
  wifi-sec.key-mgmt wpa-eap
