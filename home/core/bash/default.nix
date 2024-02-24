{ config, pkgs, ... }:

{ 
  programs.bash = {
    enable = true;
    # Commands to run in login shell
    # Placed in ~/.profile by HM
    profileExtra = ''
      # Autostart Hyprland on TTY1 login
      if [ "$(tty)" == "/dev/tty1" ]; then
          pgrep Hyprland || Hyprland
      fi
    '';
    # Commands to run in interactive shell
    # Placed in ~/.bashrc by HM, after a guard condition checking for interactive shell
    initExtra = ''
      # Source global definitions
      if [ -f /etc/bashrc ]; then
          . /etc/bashrc
      fi
      
      # User specific environment
      if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
      then
          PATH="$HOME/.local/bin:$HOME/bin:$PATH"
      fi
      export PATH
      
      # User specific aliases and functions
      if [ -d ~/.bashrc.d ]; then
          for rc in ~/.bashrc.d/*; do
              if [ -f "$rc" ]; then
                  . "$rc"
              fi
          done
      fi
      
      unset rc
      
      # set -o vi
      # bind -m vi-insert 'Control-l: clear-screen'
      
      # Change working dir in shell to last dir in lf on exit (adapted from ranger).
      lfcd () {
          tmp="$(mktemp)"
          # `command` is needed in case `lfcd` is aliased to `lf`
          command lf -last-dir-path="$tmp" "$@"
          if [ -f "$tmp" ]; then
              dir="$(\cat "$tmp")"  # prefix with backslash to escape cat="bat" alias
              rm -f "$tmp"
              if [ -d "$dir" ]; then
                  if [ "$dir" != "$(pwd)" ]; then
                      cd "$dir"
                  fi
              fi
          fi
      }
      
      ### Ctrl-O to run lfcd command:
      bind '"\C-o":"lfcd\C-m"'
      
      ### Edge Impulse CLI (for embedded AI course)
      export PATH=$PATH:~/.npm-global/bin
      
      # Eternal bash history. (source: https://superuser.com/a/664061)
      # ---------------------
      # Undocumented feature which sets the size to "unlimited".
      # https://stackoverflow.com/questions/9457233/unlimited-bash-history
      export HISTFILESIZE=
      export HISTSIZE=
      export HISTTIMEFORMAT="[%F %T] "
      # Change the file location because certain bash sessions truncate .bash_history file upon close.
      # http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
      export HISTFILE=~/.bash_eternal_history
      # Force prompt to write history after every command.
      # http://superuser.com/questions/20900/bash-history-loss
      PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
      shopt -s histappend
    '';
    shellAliases = {
      cpuclock = ''watch -n.1 "grep \"^[c]pu MHz\" /proc/cpuinfo"'';
      cputemp = ''watch -n1 "sensors"'';
      
      # Control screen backlight
      brightness-up = "brightnessctl set 5%+";
      brightness-down = "brightnessctl set 5%-";
      
      # Control output volume
      mute = "pamixer -t";
      volume-up = "pamixer -d 5";
      volume-down = "pamixer -i 5";
      
      # Control media playback
      media-pause = "playerctl play-pause";
      media-next = "playerctl next";
      media-previous = "playerctl previous";

      # Bluetooth
      bt-restart = "sudo systemctl restart bluetooth";
      btctl = "bluetoothctl";

      # Nix
      rb = "sudo nixos-rebuild switch";
      ec = "system-config-file-opener";
      flu = "nix flake update";
      try = "nix-shell -p";
      
      # FS navigation
      gc = "cd ~/10-projects/nixos";
      gs = "cd ~/10-projects/scripts";
      gp = "cd ~/10-projects";
      gdoc = "cd ~/Documents";
      gdow = "cd ~/Downloads";
      gpic = "cd ~/01-personal/04-media";
      gtor = "cd ~/04-media/00-inbox/01-torrents";
      gcou = "cd ~/Documents/exchange/courses";
      
      # Add convenient flags
      less = "less -I";  # Ignore case
      locate = "locate -i";  # Ignore case
      cp = "cp -i";  # Ask before overwriting existing file
      free = "free -m";  # Show in MB
      grep = "grep --color=auto";  # Highlight matching phrase
      
      # Replace basic commands with new & shiny versions
      cat = "bat";
      bc = "eva";
      du = "dust";
      df = "duf";
      ls = "exa";
      ll = "exa --long --group-directories-first";
      la = "exa --long --all --group-directories-first";
      lt = "exa --tree --level=3 --group-directories-first";
      cd = "z";
      
      break-pomodoro = "termdown 5m -b";
      work-pomodoro = "termdown 25m -b";
      
      vpns = "mullvad status";
      vpnu = "mullvad connect";
      vpnd = "mullvad disconnect";

      eject = "udiskie-umount";
      
      ".." = "cd ..";
      "..." = "cd ../..";

      nf = "neofetch";

      webcam = "mpv --demuxer-lavf-format=video4linux2 --demuxer-lavf-o-set=input_format=mjpeg av://v4l2:/dev/video0";
      myip = "curl --silent https://ifconfig.me";
      mk = "mkdir -p";

      # Single character
      v = "vim";
      g = "git";
      y = "wl-copy";
      p = "wl-paste";
    };
  };

  # HM modules for starship, fzf, direnv and zoxide append hooks to .bashrc
  programs.starship = {
    enable = true;

    # Below config is written to ~/.config/starship.toml
    settings = {
      add_newline = true;

      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
    };
  };
  programs.fzf.enable = true;
  programs.direnv.enable = true;
  programs.zoxide.enable = true;
}
