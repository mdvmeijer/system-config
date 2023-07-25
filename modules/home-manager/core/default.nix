args@{ config, pkgs, lib, username, ... }:

{
  imports = [
    (import ./alacritty/default.nix args)
    (import ./bash/default.nix args)
    (import ./vim/default.nix args)
    (import ./bat.nix args)
    (import ./exa.nix args)
    (import ./tmux/default.nix args)
    (import ./zathura.nix args)
    (import ./chromium.nix args)

    (import ./hyprland.nix args)
  ];
}
