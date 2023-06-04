#!/usr/bin/env bash

### Summary:
### - Allow the user to select a Kanban board contained in `taskell_dir`
### - Loop after closing taskell, i.e. allow the user to select a Kanban board again
###
### TODO:
### - Add option to exit loop
### - Add functionality for creating new Kanban board
### - Add validation for whether given Kanban board path exists, etc.

### CONFIGURATION VARIABLES
taskell_dir=~/Documents/taskell
###

while true; do
  kanban_absolute_paths=$(find $taskell_dir -type f)

  kanban_basenames=""

  # Iterate over Kanban absolute paths and store their basename in KANBAN_BASENAMES
  while IFS= read -r path; do
    basename=$(basename "$path" .md)
    kanban_basenames+="$basename\n"
  done <<< $kanban_absolute_paths

  # Allow user to select Kanban board
  kanban_selected_basename=$(echo -e $kanban_basenames | fzf)

  # Recover full path
  kanban_selected_absolute_path=$(find $taskell_dir -name "*$kanban_selected_basename*")

  taskell $kanban_selected_absolute_path
done
