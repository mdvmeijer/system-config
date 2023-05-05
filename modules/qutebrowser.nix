{ pkgs, config, ... }:

{
  home-manager.users.meeri = { pkgs, ... }: {
    home.stateVersion = "22.11";

    programs.qutebrowser.enable = true;
  };
}
