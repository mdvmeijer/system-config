{ config, pkgs, lib, username, ... }:

{
  home-manager.users.${username} = { pkgs, ... }: {
    home.stateVersion = "22.11";

    programs.exa = {
      enable = true;
    };
  };

  # environment.sessionVariables = {
  #   EXA_ICON_SPACING = "2";
  # };
}