{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    superTux
    superTuxKart
  ];
}
