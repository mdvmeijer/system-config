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

  home-manager.users.meeri = { pkgs, ... }: {
    home.stateVersion = "22.11";

    xdg.mimeApps.defaultApplications = {
      "image/png" = "feh.desktop";
      "image/jpeg" = "feh.desktop";
      "text/plain" = "gvim";
    };
  };
}
