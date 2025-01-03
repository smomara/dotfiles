#!/usr/bin/env bash

# Function to list available Wi-Fi networks
list_wifi_networks() {
    # Get Wi-Fi list, remove duplicates, remove networks with no name (--), and clean up extra spaces
    nmcli --fields "SSID,SECURITY,BARS" device wifi list | \
    tail -n +2 | \
    awk '$1 != "--" && !seen[$1]++' | \
    sed 's/  \+/ /g' | \
    column -t -s' '
}

# Function to connect to a selected Wi-Fi network
connect_to_wifi() {
    # List networks and prompt user to select one
    selected_network=$(list_wifi_networks | rofi -dmenu -i -p "Select Wi-Fi" | awk '{print $1}')
    
    # Exit if no network is selected
    if [ -z "$selected_network" ]; then
        echo "No network selected."
        exit 1
    fi

    # Check if the network is open (no security)
    security_type=$(nmcli --fields "SSID,SECURITY" device wifi list | grep -F "$selected_network" | awk '{print $2}' | head -n 1)
    
    if [ "$security_type" == "--" ]; then
        # Connect to open network
        nmcli device wifi connect "$selected_network"
    else
        # Prompt for password with a multi-line Rofi dialog
        password=$(echo -e "Enter password for:\n$selected_network" | rofi -dmenu -p "Password" -password -theme-str 'entry { placeholder: "Type here..."; }')
        if [ -z "$password" ]; then
            echo "No password provided."
            exit 1
        else
            nmcli device wifi connect "$selected_network" password "$password"
        fi
    fi
}

# Main function
main() {
    connect_to_wifi
}

# Execute main function
main
