{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    clock24 = true;
    terminal = "screen-256color";
    shortcut = "Space";
    plugins = with pkgs.tmuxPlugins; [
      dracula
      sensible
      resurrect
    ];
    extraConfig = ''
      set -g mouse on

      set -g @dracula-plugins " " 

      set-option -g default-command bash
    '';
  };
}
