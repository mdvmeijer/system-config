{ config, pkgs, ... }:

{
  services.mullvad-vpn.enable = true;
  networking.firewall.checkReversePath = "loose";
  networking.wireguard.enable = true;
}
