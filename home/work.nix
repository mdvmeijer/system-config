{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    android-studio
    slack
  ];

  programs.chromium = {
    enable = true;
      commandLineArgs = [
        # TODO: change when native wayland chromium works better
        "--ozone-platform=x11"
      ];
  };
}
