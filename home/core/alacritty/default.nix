{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";

      window = {
        opacity = 1.00;
        dynamic_title = true;
      };

      scrolling = {
        history = 10000;
        multiplier = 3;
      };

      font.normal = {
        family = "Jetbrains Mono";
        style = "Medium";
      };

      keyboard.bindings = [
        {
          key = "Return";
          mods = "Control|Shift";
          action = "SpawnNewInstance";
        }
        {
          key = "K";
          mods = "Alt";
          action = "ScrollLineUp";
        }
        {
          key = "J";
          mods = "Alt";
          action = "ScrollLineDown";
        }
        {
          key = "U";
          mods = "Alt";
          action = "ScrollHalfPageUp";
        }
        {
          key = "D";
          mods = "Alt";
          action = "ScrollHalfPageDown";
        }
        {
          key = "B";
          mods = "Alt";
          action = "ScrollPageUp";
        }
        {
          key = "F";
          mods = "Alt";
          action = "ScrollPageDown";
        }
        {
          key = "g";
          mods = "Alt";
          action = "ScrollToTop";
        }
        {
          key = "G";
          mods = "Alt";
          action = "ScrollToBottom";
        }
      ];
    };
  };
}
