{ pkgs, config, ... }:

{
  environment.systemPackages = with pkgs; [
    swaylock-effects
  ];

  # Without this, swaylock will not recognize password
  security.pam.services.swaylock = {};

  home-manager.users.meeri = {
    home.stateVersion = "22.11";
    
    home.file.".config/swaylock".source = ../dotfiles/.config/swaylock;
  };
}
