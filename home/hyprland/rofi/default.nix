{ config, pkgs, ... }:

{
  home.packages = [ pkgs.rofi-wayland ];

  home.file.".config/rofi/config.rasi".source = ./res/config.rasi;
}
