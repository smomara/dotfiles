#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar
polybar -r bar &

# Launch the secondary bar on HDMI-1 (if connected)
if xrandr --query | grep -q "HDMI-1 connected"; then
    polybar bar-hdmi &
fi
