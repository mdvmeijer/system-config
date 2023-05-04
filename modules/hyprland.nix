{ pkgs, config, inputs, pkgs-unstable, ... }:

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
    xdg-utils

    # Clipboard manager
    cliphist
    wl-clipboard

    # Screenshot tools
    grim
    slurp
    swappy

    libsForQt5.qt5ct  # Setting QT themes
    glib  # Setting GTK themes

    dolphin
    libsForQt5.breeze-qt5
    papirus-icon-theme
  ];

  # Without this, swaylock will not recognize password
  security.pam.services.swaylock = {};

  home-manager.users.meeri = { pkgs, ... }: {
    home.stateVersion = "22.11";

    # TODO: define hyprland config; right now this is not managed by Nix.

		gtk = {
    	enable = true;
    	theme = {
      	name = "Catppuccin-Macchiato-Compact-Pink-Dark";
      	package = pkgs.catppuccin-gtk.override {  # nixpkgs 22.11 does not have accents and variant params
          accents = [ "pink" ];
        	size = "compact";
        	tweaks = [ "rimless" ];
          variant = "macchiato";
      	};
    	};
  	};
  };

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };
}
