#!/usr/bin/env bash

### Summary:
### - Allows the user to select a file contained in `root_dir`
### - The selected file will be opened in vim
###
### TODO:
### - Remove common directory prefix from fzf entries

### CONFIGURATION VARIABLES
root_dir=/home/meeri/projects/system-config
###

selected_path=$(find $root_dir -type f -not -path '*.git*' | fzf)

if [ -z "$selected_path" ]; then
  echo "No file was selected"
  exit 1
fi

vim $selected_path
