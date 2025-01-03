#!/usr/bin/env bash

# Get Wi-Fi status using nmcli
WIFI=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d':' -f2)

if [[ -n $WIFI ]]; then
  echo "󰖩 $WIFI"
else
  echo "󰖪 Disconnected"
fi
