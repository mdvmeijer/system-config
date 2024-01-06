{ config, pkgs, lib, ... }:

{
  home-manager.users.meeri = {
    home.file.".config/hypr/hyprpaper.conf".text = let
      wallpaper = ./wallpapers/skyline-aesthetic-colors.png;
    in
    ''
      preload = ${wallpaper}

      wallpaper = eDP-1,${wallpaper}
      wallpaper = DP-1,${wallpaper}
      wallpaper = DP-2,${wallpaper}
      wallpaper = DP-3,${wallpaper}
      wallpaper = DP-4,${wallpaper}
      wallpaper = HDMI-A-1,${wallpaper}
    '';
  };
}

