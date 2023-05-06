{ config, pkgs, ... }:

let
  dotfiles="/dotfiles";
in
{
  imports = 
    [
      ./work-user/waybar.nix
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

    home.file.".bash_aliases".source = ./. + "/..${dotfiles}/.bash_aliases";
    home.file.".bashrc".source = ./. + "/..${dotfiles}/.bashrc";
    home.file.".tmux.conf".source = ./. + "/..${dotfiles}/.tmux.conf";
    home.file.".config/alacritty".source = ./. + "/..${dotfiles}/.config/alacritty";
    home.file.".config/dunst".source = ./. + "/..${dotfiles}/.config/dunst";
    home.file.".vim".source = ./. + "/..${dotfiles}/.vim";
  };
}
