{ pkgs, config, lib, username, ... }:

{
  home-manager.users.${username} = { pkgs, ... }: {
    # TODO: Some themes are embedded in dotfiles (vim, dunst) or not managed by Nix entirely (Qt); this needs refactoring
    # TODO: set gruvbox-material theme for adunst and Qt

    home.pointerCursor = {
      name = "Catppuccin-Macchiato-Rosewater-Cursors";
      package = pkgs.catppuccin-cursors.macchiatoRosewater;
      size = 24;
      gtk.enable = true;
    };

    gtk = {
      enable = true;
      theme = {
        name = "Gruvbox-Dark-BL";
        package = pkgs.gruvbox-gtk-theme;
      };
    };

    programs.alacritty.settings.import = [
      ../../core/alacritty/dotfiles/gruvbox/gruvbox_material.yml
    ];

    # TODO: set gruvbox theme for waybar
    programs.waybar.style = ../../core/waybar/dotfiles/catppuccin-macchiato.css;

    # TODO: set gruvbox theme for bat
    programs.bat.config.theme = "catppuccin-macchiato";
  };
}
