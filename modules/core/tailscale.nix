{ pkgs, config, ... }:

{
  environment.systemPackages = [ pkgs.tailscale-systray ];

  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "client";
}
