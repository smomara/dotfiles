#!/usr/bin/env bash

# Get the volume and mute status using wpctl
VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}')
MUTE=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $3}')

# Format the output
if [[ $MUTE == "[MUTED]" ]]; then
  echo "󰖁 muted"
else
  echo "󰕾 ${VOLUME%.*}%"
fi
