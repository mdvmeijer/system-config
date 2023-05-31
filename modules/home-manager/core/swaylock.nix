{ config, pkgs, lib, username, ... }:
{
  home-manager.users.${username} = {
    home.stateVersion = "22.11";
    
    home.file.".config/swaylock".source = ../../../dotfiles/.config/swaylock;
  };
}
