{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        "layer" = "top";
        "height" = 32;
        "spacing" = 4;  # Gaps between modules
        "modules-left" = ["hyprland/workspaces"];
        "modules-center" = ["hyprland/window"];
        "modules-right" = ["tray" "pulseaudio" "backlight" "battery" "clock"];
        "hyprland/window" = {
          "max-length" =  50;
          "separate-outputs" = true;  # have the window title be per-monitor
        };
        "hyprland/workspaces" = {
          "on-click" = "activate";
          "format" = "{name}";
          # "format" = "{name}: {icon}";
          # "format-icons" = {
          #   "1" = "";
          #   "2" = "";
          #   "3" = "";
          #   "4" = "";
          #   "5" = "";
          #   "6" = "";
          #   "7" = "";
          #   "8" = "";
          #   "9" = "";
          #   "10" = "";
          #   "focused" = "";
          #   "default" = "";
          # };
          "persistent-workspaces" = {
             "*" = 9; # 5 workspaces by default on every monitor
             # "HDMI-A-1": 3 // but only three on HDMI-A-1
          };
          "sort-by-number" = true;
        };
        "wireplumber" = {  # often mis-reports as muted, hence using pulseaudio
          "format" = "{volume}% ";
          "format-muted" = "";
          # "on-click": "helvum";
          "format-icons" = ["" "" ""];
        };
        "pulseaudio" = {
          "format" = "{volume}% {icon}";
          "format-bluetooth" = "{volume}% {icon}";
          "format-muted" = "";
          "format-icons" = {
            "headphone" = "";
            "hands-free" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = ["" ""];
          };
          "scroll-step" = 1;
          "on-click-middle" = "swayosd --output-volume mute-toggle";
          "ignored-sinks" = ["Easy Effects Sink"];
        };
        "battery" = {
          "states" = {
            "good" = 95;
            "warning" = 30;
            "critical" = 15;
          };
          "format" = "{capacity}% {icon}";
          "format-charging" = "{capacity}% ";
          "format-good" = "{capacity}% {icon}"; # An empty format will hide the module
          "format-full" = "{capacity}% {icon}";
          "format-icons" = ["" "" "" "" ""];
        };
        "bluetooth" = {
          # "controller": "controller1", // specify the alias of the controller if there are more than 1 on the system
          "format" = "";
          "format-disabled" = " off";  # an empty format will hide the module
          "format-connected" = " {num_connections}";
          "tooltip-format" = "{controller_alias}\t{controller_address}";
          "tooltip-format-connected" = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
          "tooltip-format-enumerate-connected" = "{device_alias}\t{device_address}";
        };
        "clock" = {
          "format" = "{:%a, %d %b  %H:%M}";
          "format-alt" = "{:%a, %d %b  %H:%M}";
        };
        "network" = {
          "format-wifi" = "{essid} ";
          "format-ethernet" = "";
          "format-disconnected" = "";
          "tooltip-format" = "{ipaddr}/{cidr} via {gwaddr} ";
        };
        "backlight" = {
          "device" = "intel_backlight";
          "format" = "{percent}% {icon}";
          # "format-icons" = ["" ""];
          "format-icons" = [""];
        };
        "tray" = {
          "icon-size" = 21;
          # "spacing" = 10;
        };
        "custom/mullvad" = {
          "format" = "{}";
          "interval" = 5;
          "exec" = ./scripts/waybar-mullvad-status.sh;
          "on-click" = ./scripts/waybar-mullvad-toggle.sh;
          "return-type" = "json";
        };
      };
    };
  };
}
