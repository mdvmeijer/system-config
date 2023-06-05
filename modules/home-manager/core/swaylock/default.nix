{ config, pkgs, lib, username, ... }:
{
  home-manager.users.${username} = {
    home.stateVersion = "22.11";
    
    programs.swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;
      settings = {
        key-hl-color = "C6A0F6";
        line-color = "B7BDF8";
        inside-color = "24273A";
        
        color = "2b2e37";
        layout-bg-color = "2b2e37";
        ring-color = "2b2e37";
        ring-ver-color = "B7BDF8";
        inside-wrong-color = "F15D22";
        inside-ver-color = "2b2e37";
        indicator-idle-visible = true;
        indicator-radius = 120;
        text-color = "eeeeee";
        daemonize = true;
        ignore-empty-password = true;
        show-failed-attempts = true;
      };
    };
  };
}
