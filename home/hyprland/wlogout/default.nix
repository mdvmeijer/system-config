{ config, lib, pkgs, ... }:

{
  programs.wlogout = {
    enable = true;
    layout = [
      {
          "label" = "lock";
          "action" = "${pkgs.hyprlock}/bin/hyprlock";
          "text" = "Lock";
          "keybind" = "l";
      }

      {
          "label" = "logout";
          "action" = "hyprctl dispatch exit 0";
          "text" = "Logout";
          "keybind" = "e";
      }

      {
          "label" = "shutdown";
          "action" = "systemctl poweroff";
          "text" = "Shutdown";
          "keybind" = "s";
      }

      {
          "label" = "reboot";
          "action" = "systemctl reboot";
          "text" = "Reboot";
          "keybind" = "r";
      }

      {
          "label" = "suspend";
          "action" = "systemctl suspend";
          "text" = "Suspend";
          "keybind" = "u";
      }
    ];
    style = let
      lock = ./icons/lock.png;
      logout = ./icons/logout.png;
      sleep = ./icons/sleep.png;
      power = ./icons/power.png;
      restart = ./icons/restart.png;
    in ''
      window {
          font-family: CaskaydiaCove Nerd Font, monospace;
          font-size: 12pt;
          color: #cdd6f4;
          background-color: rgba(0, 0, 0, .9);
      }

      button {
          background-repeat: no-repeat;
          background-position: center;
          background-size: 60%;
          border: none;
          color: #fbf1c7;
          text-shadow: none;
          border-radius: 20px 20px 20px 20px;
          background-color: rgba(1, 121, 111, 0);
          margin: 5px;
          transition: box-shadow 0.2s ease-in-out, background-color 0.2s ease-in-out;
      }

      button:hover {
          background-color: rgba(213, 196, 161, 0.1);
      }

      #lock {
          background-image: image(url("${lock}"));
          background-size: 70%;
      }

      #logout {
          background-image: image(url("${logout}"));
      }

      #suspend {
          background-image: image(url("${sleep}"));
      }

      #shutdown {
          background-image: image(url("${power}"));
      }

      #reboot {
          background-image: image(url("${restart}"));
      }
    '';
  };
}
