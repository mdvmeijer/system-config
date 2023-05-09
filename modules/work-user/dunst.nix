{ pkgs, config, ... }:

{
  home-manager.users.max = { pkgs, ... }: {
    home.stateVersion = "22.11";

    # home.file.".config/dunst".source = ../dotfiles/.config/dunst";
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
