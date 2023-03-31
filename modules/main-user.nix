{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  users.users = {
    meeri = {
      isNormalUser = true;
      description = "Max Meijer";
      extraGroups = [ "networkmanager" "wheel" "libvirtd" "kvm" "mlocate" ];
      initialPassword = "password";
    };
  };
}
