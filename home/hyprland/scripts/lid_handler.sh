#!/usr/bin/env bash

# Adapted from https://github.com/hyprwm/Hyprland/issues/1754#issuecomment-1775888046
if grep open /proc/acpi/button/lid/LID0/state; then
    hyprctl keyword monitor "eDP-1, 2256x1504@60, 0x0, 1.333333"
else
    if [[ `hyprctl monitors | grep "Monitor" | wc -l` != 1 ]]; then
        hyprctl keyword monitor "eDP-1, disable"
    else
        hyprlock & sleep 1; systemctl suspend &
    fi
fi
