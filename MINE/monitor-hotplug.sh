#!/bin/bash

# Function to get the active DisplayPort connected to the Samsung monitor
get_active_displayport() {
    # Use xrandr to find connected DisplayPorts and return the first one found
    for port in $(xrandr | grep 'DisplayPort-[0-9] connected' | cut -d ' ' -f1); do
        echo $port
        return
    done
}

# Function to configure display settings
configure_display() {
    local active_port=$(get_active_displayport)

    if [ -n "$active_port" ]; then
        # If a DisplayPort is connected, run the command with the correct port
        xrandr --output eDP --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-A-0 --off --output "$active_port" --mode 1920x1080 --pos 0x0 --rotate normal

        # Turn off other DisplayPorts
        for port in $(xrandr | grep 'DisplayPort-[0-9]' | cut -d ' ' -f1); do
            if [ "$port" != "$active_port" ]; then
                xrandr --output "$port" --off
            fi
        done
    else
        # If no DisplayPort is connected, run the no_external.sh script
	xrandr --output eDP --primary --mode 1920x1200 --pos 0x0 --rotate normal --output HDMI-A-0 --off --output DisplayPort-0 --off --output DisplayPort-1 --off --output DisplayPort-2 --off --output DisplayPort-3 --off --output DisplayPort-4 --off --output DisplayPort-5 --off --output DisplayPort-6 --off --output DisplayPort-7 --off --output DisplayPort-8 --off --output DisplayPort-9 --off
    fi
}

# Execute the configuration function
configure_display
