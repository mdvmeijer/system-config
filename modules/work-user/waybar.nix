{ config, pkgs, ... }:

{
  # Enable experimental options such that wlr/overlays works
  nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    })
  ];
  
  home-manager.users.max = { pkgs, ... }: {
    home.stateVersion = "22.11";

    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          "layer" = "top";
          "height" = 24;
          "spacing" = 4;  # Gaps between modules
          "modules-left" = ["wlr/workspaces" "network" "bluetooth"];
          "modules-center" = ["hyprland/window"];
          "modules-right" = ["backlight" "pulseaudio" "battery" "clock"];
          "hyprland/window" = {
            "max-length" =  50;
            "separate-outputs" = true;  # have the window title be per-monitor
          };
          "wlr/workspaces" = {
            "format" = "{name}: {icon}";
            "format-icons" = {
              "1" = "";
              "2" = "";
              "3" = "";
              "4" = "";
              "5" = "";
              "6" = "";
              "7" = "";
              "9" = "";
             "focused" = "";
              "default" = "";
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
            # "on-click" = "pavucontrol",
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
          	"format" = " {status}";
          	"format-disabled" = "";  # an empty format will hide the module
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
            "format-wifi" = "{essid} ({signalStrength}%) ";
            "format-ethernet" = "";
            "format-disconnected" = "";
            "tooltip-format" = "{ipaddr}/{cidr} via {gwaddr} ";
          };
          "backlight" = {
            "device" = "intel_backlight";
            "format" = "{percent}% {icon}";
            "format-icons" = [""];
          };
          "tray" = {
            "icon-size" = 21;
            "spacing" = 10;
          };
        };
      };
    };
  };
}
