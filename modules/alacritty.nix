{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    alacritty
  ];

  home-manager.users.meeri = { pkgs, ... }: {
    home.stateVersion = "22.11";

    home.file.".alacritty.yml".source = ../dotfiles/.alacritty.yml;
  };
}
