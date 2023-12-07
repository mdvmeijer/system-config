{ pkgs, config, lib, username, ... }:

{
  environment.systemPackages = with pkgs; [
    gnome.gnome-themes-extra
  ];

  home-manager.users.${username} = { pkgs, ... }: {
    # TODO: Some themes are embedded in dotfiles (vim, dunst); this needs refactoring
    # TODO: set gruvbox-material theme for dunst

    home.pointerCursor = {
      name = "Catppuccin-Macchiato-Rosewater-Cursors";
      package = pkgs.catppuccin-cursors.macchiatoRosewater;
      size = 24;
      gtk.enable = true;
    };

    qt = {
      enable = true;
      platformTheme = "gtk";
    };

    gtk = {
      enable = true;
      # For GTK2/3
      theme = {
        name = "Gruvbox-Dark-BL";
        package = pkgs.gruvbox-gtk-theme;
        # name = "Adwaita-dark";
      };
    };
    # For GTK4
    home.sessionVariables.GTK_THEME = "Gruvbox-Dark-BL";

    programs.alacritty.settings.import = [
      ../../core/alacritty/dotfiles/gruvbox/gruvbox_material.yml
    ];

    # TODO: set gruvbox theme for waybar
    programs.waybar.style = ../../core/waybar/dotfiles/catppuccin-macchiato.css;

    # TODO: set gruvbox theme for bat
    programs.bat.config.theme = "catppuccin-macchiato";
  };
}
