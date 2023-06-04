{ config, pkgs, lib, username, ... }:

{
  home-manager.users.${username} = {
    programs.zathura = {
      enable = true;
      options = {
        sandbox = "none";
        selection-clipboard = "clipboard";
      };
    };
  };
}
