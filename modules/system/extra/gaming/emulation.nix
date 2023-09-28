{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    pcsx2
    mgba
    desmume
  ];
}
