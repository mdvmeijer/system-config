{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # lutris
    # legendary-gl
    dwarf-fortress
    superTux
    superTuxKart
  ];
}
