{ config, pkgs, ... }:

{
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
    wallpaper = DP-5,${wallpaper}
    wallpaper = DP-6,${wallpaper}
    wallpaper = DP-7,${wallpaper}
    wallpaper = DP-8,${wallpaper}
    wallpaper = HDMI-A-1,${wallpaper}
  '';
}

