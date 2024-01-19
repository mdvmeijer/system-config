{ config, pkgs, ... }:

{
  home.packages = [ pkgs.vimiv-qt ];

  home.file.".config/vimiv/vimiv.conf" = { source = ./res/vimiv.conf; };
  home.file.".config/vimiv/keys.conf" = { source = ./res/keys.conf; };
  home.file.".config/vimiv/styles/style.conf" = { source = ./res/style.conf; };
}
