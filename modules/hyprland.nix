{ pkgs, config, ... }:

{
  # programs.hyprland.enable = true;
  programs.waybar.enable = true;

  home-manager.users.meeri = { pkgs, ... }: {
    home.stateVersion = "22.11";

    home.file.".config/hypr/hyprland.conf".source = ../dotfiles/hyprland.conf;
  };
}
