{ config, pkgs, lib, username, ... }:

{
  home-manager.users.${username} = { pkgs, ... }: {
    home.stateVersion = "22.11";

    services.dunst = {
      enable = true;
      settings = {
        global = {
          frame_color = "#8AADF4";
          separator_color = "frame";
        };

        urgency_low = {
          background = "#24273A";
          foreground = "#CAD3F5";
        };

        urgency_normal = {
          background = "#24273A";
          foreground = "#CAD3F5";
        };

        urgency_critical = {
          background = "#24273A";
          foreground = "#CAD3F5";
          frame_color = "#F5A97F";
        };
      };
    };
  };
}
