# Autostart Hyprland on TTY1 login
if [ "$(tty)" == "/dev/tty1" ]; then
    pgrep Hyprland || Hyprland
fi
