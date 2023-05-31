{ config, pkgs, lib, username, ... }:

{ 
  home-manager.users.${username} = { pkgs, ... }: {
    programs.obs-studio = {
      enable = true;
    };
  };
}
