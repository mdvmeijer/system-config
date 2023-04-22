{ pkgs, config, ... }:

{
  imports =
    [
      ./waybar.nix
    ];

  environment.systemPackages = with pkgs; [
    hyprpaper
    brightnessctl
    pamixer
    helvum
    dunst
    swaylock
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
}
