{ pkgs, config, ... }:

{
  home-manager.users.meeri = {
    programs.obs-studio = {
      enable = true;
    };
  };
}
