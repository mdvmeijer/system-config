{ config, pkgs, lib, username, ... }:

{ 
  home-manager.users.${username} = { pkgs, ... }: {
    home.stateVersion = "22.11";

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
        
        if command -v fzf-share >/dev/null; then
          source "$(fzf-share)/key-bindings.bash"
          source "$(fzf-share)/completion.bash"
        fi
        
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
        
        eval "$(starship init bash)"

        eval "$(direnv hook bash)"
      '';
      shellAliases = {
        clockmon = ''watch -n.1 "grep \"^[c]pu MHz\" /proc/cpuinfo"'';
        tempmon = ''watch -n1 "sensors"'';
        
        gtop = "sudo intel_gpu_top";
        
        # Check power limits
        st-rapl = "cat /sys/class/powercap/intel-rapl/intel-rapl\:0/constraint_1_power_limit_uw";
        lt-rapl = "cat /sys/class/powercap/intel-rapl/intel-rapl\:0/constraint_0_power_limit_uw";
        
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
        
        # Add convenient flags
        ls = "exa";
        lm = "exa --long --group-directories-first";
        ll = "exa --long --all --group-directories-first";
        lt = "exa --tree --level=3 --group-directories-first";
        less = "less -I";  # Ignore case
        locate = "locate -i";  # Ignore case
        cp = "cp -i";  # Ask before overwriting existing file
        free = "free -m";  # SHow in MB
        grep = "grep --color=auto";  # Highlight matching phrase
        
        v = "vim";

        bt-restart = "sudo systemctl restart bluetooth";
        btctl = "bluetoothctl";

        # Nix shorthands
        rb = "sudo nixos-rebuild switch --flake ~/projects/system-config#lateralus";
        flu = "nix flake update";
        try = "nix-shell -p";
        
        # FS navigation shorthands
        gc = "cd ~/projects/system-config";
        gs = "cd ~/projects/scripts";
        gp = "cd ~/projects";
        gdoc = "cd ~/Documents";
        gdow = "cd ~/Downloads";
        gpic = "cd ~/Pictures";
        gtor = "cd ~/Torrents";
        gcou = "cd ~/Documents/exchange/courses";
        
        # Edit file shorthands
        ec = "system-config-file-opener";
        
        # Git shorthands
        branch = "git branch";
        checkout = "git checkout";
        commit = "git commit -m";
        fetch = "git fetch";
        pull = "git pull origin";
        push = "git push origin";
        status = "git status";
        
        cat = "bat";
        bc = "eva";
        du = "dust";
        df = "duf";
        
        break-pomodoro = "termdown 5m -b";
        work-pomodoro = "termdown 25m -b";
        
        vpns = "mullvad status";
        vpnu = "mullvad connect";
        vpnd = "mullvad disconnect";
        
        ".." = "cd ..";
        "..." = "cd ../..";
      };
    };

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
  };

}
