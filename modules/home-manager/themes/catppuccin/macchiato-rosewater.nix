{ pkgs, config, lib, username, ... }:

{
  home-manager.users.${username} = { pkgs, ... }: {
    # TODO: Some themes are embedded in dotfiles (e.g. alacritty, dunst); this needs refactoring

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

    programs.waybar.style = ../../../../dotfiles/.config/waybar/style.css;
  };
}
