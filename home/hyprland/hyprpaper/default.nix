{ config, pkgs, ... }:

{
  home.file.".config/hypr/hyprpaper.conf".text = let
    wallpaper-laptop = ./wallpapers/louis-picard-perfect-blue-poster-no-text.jpg;
    wallpaper-external = ./wallpapers/sif.png;
  in
  ''
    preload = ${wallpaper-laptop}
    preload = ${wallpaper-external}

    wallpaper = eDP-1,${wallpaper-laptop}
    wallpaper = DP-1,${wallpaper-external}
    wallpaper = DP-2,${wallpaper-external}
    wallpaper = DP-3,${wallpaper-external}
    wallpaper = DP-4,${wallpaper-external}
    wallpaper = DP-5,${wallpaper-external}
    wallpaper = DP-6,${wallpaper-external}
    wallpaper = DP-7,${wallpaper-external}
    wallpaper = DP-8,${wallpaper-external}
    wallpaper = HDMI-A-1,${wallpaper-external}
  '';
}

