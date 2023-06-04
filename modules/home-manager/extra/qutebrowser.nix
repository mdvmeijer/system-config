{ config, pkgs, lib, username, ... }:

{ 
  home-manager.users.${username} = { pkgs, ... }: {
    home.stateVersion = "22.11";

    programs.qutebrowser.enable = true;
  };
}
