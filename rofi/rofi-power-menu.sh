#!/usr/bin/env bash

# Power menu options with icons
OPTIONS=" Shutdown\n Reboot\n Logout\n Lock\n Suspend"

# Show the menu with Rofi
CHOICE=$(echo -e $OPTIONS | rofi -dmenu -i -p "Power Menu" -theme ~/.config/rofi/gruvbox-material.rasi | tr -d '\n')

# Debug: Print the selected choice
echo "Selected: '$CHOICE'"

# Handle the selected option
case $CHOICE in
  " Shutdown")
    systemctl poweroff
    ;;
  " Reboot")
    systemctl reboot
    ;;
  " Lock")
    wpctl set-mute @DEFAULT_AUDIO_SINK@ 1
    i3lock -c 000000
    ;;
  " Suspend")
    wpctl set-mute @DEFAULT_AUDIO_SINK@ 1
    i3lock -c 000000 && systemctl suspend
    ;;
  *)
    echo "No option selected"
    ;;
esac
