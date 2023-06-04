{ config, pkgs, lib, username, ... }:

{
  home-manager.users.${username} = { pkgs, ... }: {
    home.stateVersion = "22.11";

    programs.alacritty = {
      enable = true;
      settings = {
        import = [
          ./dotfiles/catppuccin/catppuccin-macchiato.yml
        ];

        env.TERM = "xterm-256color";

        window = {
          opacity = 1.00;
          dynamic_title = true;
        };

        scrolling = {
          history = 10000;
          multiplier = 3;
          auto_scroll = false;
        };

        tabspaces = 4;

        font.normal = {
          family = "agave";
          style = "Regular";
        };

        key_bindings = [
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
  };
}
