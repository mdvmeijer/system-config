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
          key = "PageUp";
          mods = "Shift";
          action = "ScrollPageUp";
        }
        {
          key = "PageDown";
          mods = "Shift";
          action = "ScrollPageDown";
        }
        {
          key = "Home";
          mods = "Shift";
          action = "ScrollToTop";
        }
        {
          key = "End";
          mods = "Shift";
          action = "ScrollToBottom";
        }
      ];
    };
  };
}
