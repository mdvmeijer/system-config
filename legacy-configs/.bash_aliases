# case-insensitive search
alias less="less -I"
                                                                                                                                                   
alias srcbash="source ~/.bashrc"
 
alias cloudbox="ssh meeri@cloudbox"

alias conf="cd ~/.system-config"

alias ll="ls -lah"

alias nixos-rebuild="sudo nixos-rebuild switch --flake ~/.system-config#meeri --impure"

alias edit-nixos-conf="vim ~/.system-config/modules/configuration.nix"


alias set-powersave-profile="sudo ~/.system-config/legacy-configs/power-management/set-powersave-profile"
alias set-balanced-profile="sudo ~/.system-config/legacy-configs/power-management/set-balanced-profile"
alias set-performance-profile="sudo ~/.system-config/legacy-configs/power-management/set-performance-profile"
alias set-extreme-profile="sudo ~/.system-config/legacy-configs/power-management/set-extreme-profile"

alias run-fanctrl="sudo ~/bin/fw-fanctrl-autostart"

alias clock-monitor='watch -n.1 "grep \"^[c]pu MHz\" /proc/cpuinfo"'
alias temp-monitor='watch "sensors"'
