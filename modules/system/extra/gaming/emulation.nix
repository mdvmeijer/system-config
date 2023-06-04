{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    pcsx2
  ];
}
