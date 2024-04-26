#!/usr/bin/env sh

wpctl_status=$(wpctl status)
sinks_title_linenr=$(grep -n -m 1 'Sinks:' <<< $wpctl_status | cut -d: -f1)
sinks_title_linenr_plus1=$((sinks_title_linenr + 1))

# The section below the 'sinks' section is the 'sources' section, so use it as end of the range
sources_title_linenr=$(grep -n -m 1 'Sources:' <<< $wpctl_status | cut -d: -f1)
sources_title_linenr_minus2=$((sources_title_linenr - 2))

selected_sink=$(sed -n "${sinks_title_linenr_plus1},${sources_title_linenr_minus2}p" <<< $wpctl_status | cut -d" " -f3- | rofi -dmenu)
[ -z "$selected_sink" ] && exit 0 # Exit if no value selected

echo $selected_sink | cut -d" " -f1 | xargs wpctl set-default
