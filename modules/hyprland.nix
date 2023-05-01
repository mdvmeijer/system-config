{ pkgs, config, inputs, ... }:

{
  imports =
    [
      ./waybar.nix
    ];

  environment.systemPackages = with pkgs; [
    hyprpaper
    brightnessctl
    pamixer
    playerctl
    helvum
    dunst
    swaylock-effects
    pavucontrol
    wlr-randr

    # Screenshot tools
    grim
    slurp
    swappy

    # Clipboard manager
    cliphist
    wl-clipboard

    libsForQt5.qt5ct  # Setting QT themes
    glib  # Setting GTK themes
  ];

  # Without this, swaylock will not recognize password
  security.pam.services.swaylock = {};

  home-manager.users.meeri = { pkgs, ... }: {
    home.stateVersion = "22.11";

    # TODO: define hyprland config; right now this is not managed by Nix.
  };

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };
}
