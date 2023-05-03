{ pkgs, config, ... }:

{
  home-manager.users.meeri = { pkgs, ... }: {
    home.stateVersion = "22.11";

    home.pointerCursor = {
      name = "Catppuccin-Macchiato-Rosewater-Cursors";
      package = pkgs.catppuccin-cursors.macchiatoRosewater;
      size = 24;
      gtk.enable = true;
    };
  };
}
