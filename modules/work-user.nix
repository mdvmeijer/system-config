{ config, pkgs, ... }:

let
  dotfiles="/dotfiles";
in
{
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
      jetbrains.rider
    ];

    home.file.".bash_aliases".source = ./. + "/..${dotfiles}/.bash_aliases";
    home.file.".bashrc".source = ./. + "/..${dotfiles}/.bashrc";
    home.file.".tmux.conf".source = ./. + "/..${dotfiles}/.tmux.conf";
    home.file.".alacritty.yml".source = ./. + "/..${dotfiles}/.alacritty.yml";
  };
}
