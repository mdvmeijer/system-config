args@{ config, pkgs, lib, username, ... }:

{
  imports = [
    (import ./alacritty args)
    (import ./bash args)
    (import ./bat.nix args)
    (import ./tmux args)

    (import ../hyprland args)
    ./doom-emacs
  ];

  home-manager.users.meeri = {
    programs.obs-studio.enable = true;
    programs.eza.enable = true;

    programs.zathura = {
      enable = true;
      options = {
        sandbox = "none";
        selection-clipboard = "clipboard";
      };
    };

    services.batsignal.enable = true; # Battery daemon
  };
}
