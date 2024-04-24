{ config, pkgs, ... }:

{
  home.file.".config/hypr/hyprpaper.conf".text = let
    wallpaper1 = ./wallpapers/anime_skull.png;
    wallpaper2 = ./wallpapers/sif.png;
  in
  ''
    preload = ${wallpaper1}
    preload = ${wallpaper2}

    wallpaper = eDP-1,${wallpaper1}
    wallpaper = DP-1,${wallpaper2}
    wallpaper = DP-2,${wallpaper2}
    wallpaper = DP-3,${wallpaper2}
    wallpaper = DP-4,${wallpaper2}
    wallpaper = DP-5,${wallpaper2}
    wallpaper = DP-6,${wallpaper2}
    wallpaper = DP-7,${wallpaper2}
    wallpaper = DP-8,${wallpaper2}
    wallpaper = HDMI-A-1,${wallpaper2}
  '';
}

