{ config, pkgs, lib, username, ... }:
{
  home-manager.users.${username} = {
    home.stateVersion = "22.11";
    
    home.file.".config/swaylock/config".source = ./dotfiles/config;
  };
}
