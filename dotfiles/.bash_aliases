# case-insensitive search
alias less="less -I"
                                                                                                                                                   
alias srcbash="source ~/.bashrc"
 
alias cloudbox="ssh meeri@cloudbox"

alias conf="cd ~/.system-config"

alias ll="ls -lah"

alias locate="locate -i" # ignore case


alias nixos-rebuild="sudo nixos-rebuild switch --flake ~/.system-config#lateralus --impure"

alias clock-monitor='watch -n.1 "grep \"^[c]pu MHz\" /proc/cpuinfo"'
alias temp-monitor='watch "sensors"'

alias st-rapl="cat /sys/class/powercap/intel-rapl/intel-rapl\:0/constraint_1_power_limit_uw"
alias lt-rapl="cat /sys/class/powercap/intel-rapl/intel-rapl\:0/constraint_0_power_limit_uw"

alias lfconf="lf ~/.system-config"
