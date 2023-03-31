{ config, pkgs, ... }:

{ 
  home-manager.users.meeri = { pkgs, ... }: {
    home.stateVersion = "22.11";

    home.file.".bash_aliases".source = ../dotfiles/.bash_aliases;
    home.file.".bashrc".source = ../dotfiles/.bashrc;
  };
}
