{ config, pkgs, lib, username, ... }:

{
  home-manager.users.${username} = { pkgs, ... }: {
    services.dunst = {
      enable = true;
      settings = {

        global = {
          frame_color = "#A6A6A6";
          separator_color = "frame";
          font = "PT Serif";
          monitor = "0";  # Initially appear on primary monitor
          follow = "mouse";  # But do follow the cursor
          geometry = "0x0-30+20";
          corner_radius = "6";
          frame_width = "2";
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
