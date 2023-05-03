{ pkgs, config, ... }:

{
  home-manager.users.meeri = { pkgs, ... }: {
    home.stateVersion = "22.11";

    home.file.".config/dunst".source = ../dotfiles/.config/dunst";
  };
}
