{ pkgs, config, ... }:

{
  home-manager.users.max = {
    home.stateVersion = "22.11";
    
    home.file.".config/swaylock".source = ../../dotfiles/.config/swaylock;
  };
}
