{ pkgs, config, username, ... }:

{
  home-manager.users.${username} = {
    programs.chromium = {
      enable = true;
      commandLineArgs = [
        # TODO: change when native wayland chromium works better
        "--ozone-platform=x11"
      ];
    };
  };
}
