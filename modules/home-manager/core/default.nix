args@{ config, pkgs, lib, username, ... }:

{
  imports = [
    (import ./alacritty.nix args)
    (import ./bash.nix args)
    (import ./bat.nix args)
    (import ./exa.nix args)
    (import ./tmux.nix args)
    (import ./vim.nix args)
    (import ./zathura.nix args)

    (import ./hyprland.nix args)
  ];
}
