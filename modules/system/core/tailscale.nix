{ pkgs, config, ... }:

{
  environment.systemPackages = [ pkgs.tailscale ];

  services.tailscale.enable = true;
}
