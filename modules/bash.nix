{ config, pkgs, ... }:

{ 
  home-manager.users.meeri = { pkgs, ... }: {
    home.stateVersion = "22.11";

    home.file.".bash_aliases".source = ../dotfiles/.bash_aliases;
    home.file.".bashrc".source = ../dotfiles/.bashrc;

    programs.starship = {
      enable = true;

      # Below config is written to ~/.config/starship.toml
      settings = {
        add_newline = true;

        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        };
      };
    };
  };

}
