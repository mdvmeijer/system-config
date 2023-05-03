alias clockmon='watch -n.1 "grep \"^[c]pu MHz\" /proc/cpuinfo"'
alias tempmon='watch -n1 "sensors"'

alias gtop="sudo intel_gpu_top"

# Check power limits
alias st-rapl="cat /sys/class/powercap/intel-rapl/intel-rapl\:0/constraint_1_power_limit_uw"
alias lt-rapl="cat /sys/class/powercap/intel-rapl/intel-rapl\:0/constraint_0_power_limit_uw"

# Add convenient flags
alias ll="ls -lah"
alias less="less -I"  # Ignore case
alias locate="locate -i"  # Ignore case
alias cp="cp -i"  # Ask before overwriting existing file
alias df="df -h"  # Show human-readable
alias free="free -m"  # SHow in MB
alias grep="grep --color=auto"  # Highlight matching phrase

# Nix shorthands
alias rb="sudo nixos-rebuild switch --flake ~/.system-config#lateralus"
alias flu="nix flake update"

# FS navigation shorthands
alias gc="cd ~/.system-config"
alias gs="cd ~/scripts"
alias gdoc="cd ~/Documents"
alias gdow="cd ~/Downloads"
alias gpic="cd ~/Pictures"
alias gtor="cd ~/Torrents"
alias gcou="cd ~/Documents/exchange/courses"

# Git shorthands
alias branch="git branch"
alias checkout="git checkout"
alias commit="git commit -m"
alias fetch="git fetch"
alias pull="git pull origin"
alias push="git push origin"
alias status="git status"
