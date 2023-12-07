{ pkgs, config, inputs, ... }:

{
  imports =
    [
      inputs.hyprland.nixosModules.default
      ./swaylock.nix
    ];

  # Module from inputs.hyprland substitutes nixpkgs `programs.hyprland` with its own,
  # allowing for pulling the latest changes once they are available.
  # Besides installing the Hyprland package, this module sets some system-wide configuration
  # (e.g. polkit, xdg-desktop-portal-hyprland)
  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    hyprpaper
    brightnessctl
    pamixer
    playerctl
    helvum
    pavucontrol
    wlr-randr
    xdg-utils
    hyprpicker
    swayosd

    # Clipboard manager
    cliphist
    wl-clipboard

    # Screenshot tools
    grim
    slurp
    swappy

    dolphin
    gnome.nautilus
    papirus-icon-theme
  ];

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };
}
