{ config, pkgs, ... }:

let
  dotfiles="/dotfiles";
in
{
  imports = 
    [
      ./work-user/waybar.nix
      ./work-user/hyprland.nix
      ./work-user/themes/catppuccin/macchiato-rosewater.nix
  ];

  nixpkgs.config.allowUnfree = true;

  users.users = {
    max = {
      isNormalUser = true;
      description = "MYP";
      extraGroups = [ "networkmanager" "wheel" "libvirtd" "kvm" "mlocate" ];
      initialPassword = "password";
    };
  };

  home-manager.users.max = { pkgs, ... }: {
    home.stateVersion = "22.11";

    home.packages = with pkgs; [
      android-studio
      slack
      yubikey-manager-qt
      yubikey-manager
    ];

    programs.git = {
      enable = true;
      userName = "M.D.V. Meijer";
      userEmail = "max.meijer@mindyourpass.com";
    };

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

    programs.zathura = {
      enable = true;
      options = {
        sandbox = "none";
        selection-clipboard = "clipboard";
      };
    };

    programs.alacritty = {
      enable = true;
      settings = {
        import = [
          ../dotfiles/.config/alacritty/catppuccin/catppuccin-macchiato.yml
        ];

        env.TERM = "xterm-256color";

        window = {
          opacity = 0.90;
          dynamic_title = true;
        };

        scrolling = {
          history = 10000;
          multiplier = 3;
          auto_scroll = false;
        };

        tabspaces = 4;

        font.normal = {
          family = "agave";
          style = "Regular";
        };

        key_bindings = [
          {
            key = "PageUp";
            mods = "Shift";
            action = "ScrollPageUp";
          }
          {
            key = "PageDown";
            mods = "Shift";
            action = "ScrollPageDown";
          }
          {
            key = "Home";
            mods = "Shift";
            action = "ScrollToTop";
          }
          {
            key = "End";
            mods = "Shift";
            action = "ScrollToBottom";
          }
        ];
      };
    };

    home.file.".bashrc".source = ./. + "/..${dotfiles}/.bashrc";
    home.file.".bash_aliases".source = ./. + "/..${dotfiles}/.bash_aliases";
    home.file.".bash_profile".source = ./. + "/..${dotfiles}/.bash_profile";

    home.file.".tmux.conf".source = ./. + "/..${dotfiles}/.tmux.conf";
    home.file.".vim".source = ./. + "/..${dotfiles}/.vim";
  };

  nixpkgs.config.permittedInsecurePackages = [
    "electron-21.4.0"
  ];
}
