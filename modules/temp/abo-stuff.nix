{ config, pkgs, ... }:

{
  # make sure eduroam works
  networking.wireless.enable = false;
  networking.wireless.iwd.enable = true;
  networking.networkmanager.wifi.backend = "iwd";
  # services.connman.wifi.backend = "iwd"; # maybe can be removed?

  # Abo Akademi vpn
  # https://blog.tomontheinternet.com/posts/using-l2tp-vpn-on-nixos/
  networking.networkmanager.enableStrongSwan = true;
  services.xl2tpd.enable = true;
  services.strongswan = {
    enable = true;
    secrets = [ "ipsec.d/ipsec.nm-l2tp.secrets" ];
  };
}
