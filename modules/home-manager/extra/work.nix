{ config, pkgs, ... }:

{
  programs.adb.enable = true;

  home-manager.users.meeri = {
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
  };
}
