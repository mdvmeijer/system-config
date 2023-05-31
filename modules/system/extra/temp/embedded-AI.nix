{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gnumake
    arduino
    arduino-cli
    screen
  ];
}
