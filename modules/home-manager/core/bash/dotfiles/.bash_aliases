alias clockmon='watch -n.1 "grep \"^[c]pu MHz\" /proc/cpuinfo"'
alias tempmon='watch -n1 "sensors"'

alias gtop="sudo intel_gpu_top"

# Check power limits
alias st-rapl="cat /sys/class/powercap/intel-rapl/intel-rapl\:0/constraint_1_power_limit_uw"
alias lt-rapl="cat /sys/class/powercap/intel-rapl/intel-rapl\:0/constraint_0_power_limit_uw"

# Control screen backlight
alias brightness-up="brightnessctl set 5%+"
alias brightness-down="brightnessctl set 5%-"

# Control output volume
alias mute="pamixer -t"
alias volume-up="pamixer -d 5"
alias volume-down="pamixer -i 5"

# Control media playback
alias media-pause="playerctl play-pause"
alias media-next="playerctl next"
alias media-previous="playerctl previous"

# Add convenient flags
alias ll="exa --long --all --group-directories-first"
alias lt="exa --tree --level=3 --group-directories-first"
alias less="less -I"  # Ignore case
alias locate="locate -i"  # Ignore case
alias cp="cp -i"  # Ask before overwriting existing file
alias df="df -h"  # Show human-readable
alias free="free -m"  # SHow in MB
alias grep="grep --color=auto"  # Highlight matching phrase

alias v="vim"
alias blt-restart="sudo systemctl restart bluetooth"

# Nix shorthands
alias rb="sudo nixos-rebuild switch --flake ~/projects/system-config#lateralus"
alias flu="nix flake update"
alias try="nix-shell -p"

# FS navigation shorthands
alias gc="cd ~/projects/system-config"
alias gs="cd ~/scripts"
alias gdoc="cd ~/Documents"
alias gdow="cd ~/Downloads"
alias gpic="cd ~/Pictures"
alias gtor="cd ~/Torrents"
alias gcou="cd ~/Documents/exchange/courses"

# Edit file shorthands
alias ec="system-config-file-opener"

# Git shorthands
alias branch="git branch"
alias checkout="git checkout"
alias commit="git commit -m"
alias fetch="git fetch"
alias pull="git pull origin"
alias push="git push origin"
alias status="git status"

alias cat="bat"
alias bc="eva"
alias du="dust"
alias df="duf"

alias break-pomodoro="termdown 5m -b"
alias work-pomodoro="termdown 25m -b"

alias vpns="mullvad status"
alias vpnu="mullvad connect"
alias vpnd="mullvad disconnect"

alias ..="cd .."
alias ...="cd ../.."
