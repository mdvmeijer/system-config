{ config, pkgs, ... }:

{
  home-manager.users.meeri = { pkgs, ... }: {
    home.stateVersion = "22.11";

    programs.alacritty = {
      enable = true;
      settings = {
        import = [
          ../dotfiles/.config/alacritty/catppuccin/catppuccin-macchiato.yml
        ];

        env.TERM = "xterm-256color";

        window = {
          opacity = 0.90;
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
