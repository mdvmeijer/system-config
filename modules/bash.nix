{ config, pkgs, ... }:

{ 
  home-manager.users.meeri = { pkgs, ... }: {
    home.stateVersion = "22.11";

    # programs.bash = {
    #   enable = true;
    #   bashrcExtra = ''
    #     . ~/.legacy_bashrc
    #     . ~/.bash_aliases
    #   '';
    # };

    # home.file.".legacy_bashrc".source = ../dotfiles/.bashrc;
    home.file.".bashrc".source = ../dotfiles/.bashrc;
    home.file.".bash_aliases".source = ../dotfiles/.bash_aliases;
    home.file.".bash_profile".source = ../dotfiles/.bash_profile;

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
