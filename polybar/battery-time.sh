#!/usr/bin/env bash

# Get battery status and capacity
BATTERY_PATH="/sys/class/power_supply/BAT0"
STATUS=$(cat $BATTERY_PATH/status)
CAPACITY=$(cat $BATTERY_PATH/capacity)

# Calculate time remaining
if [[ $STATUS == "Charging" ]]; then
  # Try to get charging power (in µW)
  if [[ -f $BATTERY_PATH/power_now ]]; then
    POWER=$(cat $BATTERY_PATH/power_now)
    # Convert to W
    POWER=$(echo "$POWER / 1000000" | bc)
    # Check if POWER is greater than zero
    if (( $(echo "$POWER > 0" | bc -l) )); then
      # Get battery energy (in Wh)
      ENERGY=$(cat $BATTERY_PATH/energy_full)
      # Convert to Wh
      ENERGY=$(echo "$ENERGY / 1000000" | bc)
      # Calculate time remaining (in hours)
      TIME=$(echo "scale=2; ($ENERGY - ($ENERGY * $CAPACITY / 100)) / $POWER" | bc)
      # Format time
      if [[ $TIME == "0" ]]; then
        TIME="00:00"
      else
        TIME=$(date -u -d @$(echo "$TIME * 3600" | bc) +"%H:%M")
      fi
      echo "󰂄 $CAPACITY% ($TIME)"
    else
      echo "󰂄 $CAPACITY%"
    fi
  else
    echo "󰂄 $CAPACITY%"
  fi
elif [[ $STATUS == "Discharging" ]]; then
  # Try to get discharging power (in µW)
  if [[ -f $BATTERY_PATH/power_now ]]; then
    POWER=$(cat $BATTERY_PATH/power_now)
    # Convert to W
    POWER=$(echo "$POWER / 1000000" | bc)
    # Check if POWER is greater than zero
    if (( $(echo "$POWER > 0" | bc -l) )); then
      # Get battery energy (in Wh)
      ENERGY=$(cat $BATTERY_PATH/energy_full)
      # Convert to Wh
      ENERGY=$(echo "$ENERGY / 1000000" | bc)
      # Calculate time remaining (in hours)
      TIME=$(echo "scale=2; ($ENERGY * $CAPACITY / 100) / $POWER" | bc)
      # Format time
      if [[ $TIME == "0" ]]; then
        TIME="00:00"
      else
        TIME=$(date -u -d @$(echo "$TIME * 3600" | bc) +"%H:%M")
      fi
      echo "󰁹 $CAPACITY% ($TIME)"
    else
      echo "󰁹 $CAPACITY%"
    fi
  else
    echo "󰁹 $CAPACITY%"
  fi
else
  echo "󰁹 $CAPACITY%"
fi
