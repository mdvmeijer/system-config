{ config, pkgs, ... }:

{
  home-manager.users.meeri = { pkgs, ... }: {
    home.packages = with pkgs; [
      # lutris
      # legendary-gl
      dwarf-fortress
      superTux
      superTuxKart
    ];
  };
}
