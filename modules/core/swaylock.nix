{ pkgs, config, ... }:

{
  # Without this, swaylock will not recognize password
  security.pam.services.swaylock = {};
}
