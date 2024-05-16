{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    virtiofsd
  ];

  programs.virt-manager.enable = true;

  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
}
