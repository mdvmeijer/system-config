#!/usr/bin/env bash
#
# USAGE: usb-automount-starter $device
#   $device  is the actual device node at /dev/$device

automounter="$1"
device="$2"

$automounter $device &
