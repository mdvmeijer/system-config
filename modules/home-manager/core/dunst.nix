{ config, pkgs, lib, username, ... }:

{
  home-manager.users.${username} = { pkgs, ... }: {
    home.stateVersion = "22.11";

    services.dunst = {
      enable = true;
      settings = {

        global = {
          frame_color = "#A6A6A6";
          separator_color = "frame";
          font = "Jetbrains Mono";
          monitor = "0";  # Initially appear on primary monitor
          follow = "mouse";  # But do follow the cursor
          geometry = "0x0-30+20";
          corner_radius = "6";
        };

        urgency_low = {
          background = "#2B2B2B";
          foreground = "#CAD3F5";
        };

        urgency_normal = {
          background = "#2B2B2B";
          foreground = "#CAD3F5";
        };

        urgency_critical = {
          background = "#2B2B2B";
          foreground = "#CAD3F5";
          frame_color = "#F5A97F";
        };
      };
    };
  };
}
