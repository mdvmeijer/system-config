#!/usr/bin/env bash

### Basic version of this script was generated by ChatGPT on 26-05-2023

mkdir -p "$XDG_DATA_HOME/key-value-store"
data_file="$XDG_DATA_HOME/key-value-store/store"

# Create data file if it doesn't exist already
[ ! -e "$data_file" ] && touch "$data_file"

# Function to store a key-value pair
set_value() {
    key="$1"
    # TODO: Handle situation where key already exists
    
    value="$2"
    echo "$key=$value" >> "$data_file"
    # Value stored: $key=$value
    return 0
}

# Function to retrieve a value for a given key
get_value() {
    key="$1"
    value=$(grep "^$key=" "$data_file" | cut -d '=' -f2)
    if [ -n $value ]; then
        wl-copy "$value"
        # Value corresponding to key $key has been copied to the clipboard
        return 0
    else
        # No value found for key $key
        return 1
    fi
}

# Function to display the wofi menu
show_set_menu() {
    key=$(echo " " | wofi --dmenu --prompt "Enter a key:")
    [ -z "$key" ] && notify-send "Value storage cancelled" "Invalid key" && exit 1

    value=$(echo "Enter a value:" | wofi --dmenu --prompt "Enter a value:")
    [ -z "$value" ] && notify-send "Value storage cancelled" "Invalid value" && exit 1

    set_value "$key" "$value"
    [ $? -ne 0 ] && notify-send "Value storage error" "Something went wrong" && exit 1
    
    notify-send --expire-time=2000 "Value storage success" "Value for key \"$key\" stored in database"
}

show_get_menu() {
    key=$(cat $data_file | cut -d '=' -f1 | wofi --dmenu --matching=fuzzy --prompt "Enter a key:")
    [ -z "$key" ] && notify-send "Value retrieval cancelled" "An invalid key was entered" && exit 1
    # TODO: Check whether key is present in data file

    get_value "$key"
    [ $? -ne 0 ] && notify-send "Value retrieval error" "No value was found for key \"$key\"" && exit 1
      
    notify-send --expire-time=2000 "Value retrieval success" "Value for key \"$key\" copied to clipboard"
}

[ "$1" == "set" ] && show_set_menu
[ "$1" == "get" ] && show_get_menu