{ config, pkgs, ... }:

{
  home-manager.users.meeri = { pkgs, ... }: {
    home.stateVersion = "22.11";

    programs.exa = {
      enable = true;
    };
  };

  environment.sessionVariables = {
    EXA_ICON_SPACING = "2";
  };
}
