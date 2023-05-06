{ pkgs, config, ... }:

{
  home-manager.users.meeri = {
    programs.zathura = {
      enable = true;
      options = {
        sandbox = "none";
        selection-clipboard = "clipboard";
      };
    };
  };
}
