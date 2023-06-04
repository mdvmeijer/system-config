{ pkgs, config, ... }:

{
  environment.systemPackages = with pkgs; [
    swaylock-effects
  ];

  # Without this, swaylock will not recognize password
  security.pam.services.swaylock = {};
}
