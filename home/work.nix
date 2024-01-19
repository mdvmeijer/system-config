{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    android-studio
    slack
    drawio
  ];

  programs.chromium = {
    enable = true;
      commandLineArgs = [
        # TODO: change when native wayland chromium works better
        "--ozone-platform=x11"
      ];
  };
}
