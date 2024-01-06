{ pkgs, config, lib, meeri, ... }:

{
  home-manager.users.meeri = { pkgs, ... }: {
    # TODO: Some themes are embedded in dotfiles (vim, dunst) or not managed by Nix entirely (Qt); this needs refactoring

    home.pointerCursor = {
      name = "Catppuccin-Macchiato-Rosewater-Cursors";
      package = pkgs.catppuccin-cursors.macchiatoRosewater;
      size = 24;
      gtk.enable = true;
    };

    gtk = {
      enable = true;
      theme = {
        name = "Catppuccin-Macchiato-Compact-Pink-Dark";
        package = pkgs.catppuccin-gtk.override {
          accents = [ "pink" ];
          size = "compact";
          tweaks = [ "rimless" ];
          variant = "macchiato";
        };
      };
    };

    programs.alacritty.settings.import = [
      ../../core/alacritty/dotfiles/catppuccin/catppuccin-macchiato.yml
    ];

    programs.waybar.style = ../../hyprland/waybar/dotfiles/catppuccin-macchiato.css;

    programs.bat.config.theme = "catppuccin-macchiato";
  };
}
