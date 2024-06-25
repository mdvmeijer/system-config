{ pkgs, config, ... }:

{
  # TODO: Some themes are embedded in dotfiles (vim, dunst); this needs refactoring
  # TODO: set gruvbox-material theme for dunst

  home.pointerCursor = {
    name = "catppuccin-macchiato-rosewater-cursors";
    package = pkgs.catppuccin-cursors.macchiatoRosewater;
    size = 24;
    gtk.enable = true;
  };

  qt = {
    enable = true;
    # TODO: Set dark theme
    # platformTheme = "gtk";
  };

  gtk = {
    enable = true;
    # For GTK2/3
    theme = {
      # name = "Gruvbox-Dark-BL-LB";
      # package = pkgs.gruvbox-gtk-theme;
      name = "Adwaita-dark";
    };
  };
  # For GTK4
  # home.sessionVariables.GTK_THEME = "Gruvbox-Dark-BL-LB";
  home.sessionVariables.GTK_THEME = "Adwaita-dark";

  programs.alacritty.settings.import = [
    ../../core/alacritty/dotfiles/gruvbox/gruvbox_material.toml
  ];

  # TODO: set gruvbox theme for waybar
  programs.waybar.style = ../../hyprland/waybar/dotfiles/catppuccin-macchiato.css;

  # TODO: set gruvbox theme for bat
  programs.bat.config.theme = "catppuccin-macchiato";
}
