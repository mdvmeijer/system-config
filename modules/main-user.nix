{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  users.users = {
    meeri = {
      isNormalUser = true;
      description = "Max Meijer";
      extraGroups = [ 
        "networkmanager"
        "wheel"
        "libvirtd"
        "kvm"
        "mlocate"
        "dialout"  # Access to serial ports, e.g. for Arduino
      ];
      initialPassword = "password";
    };
  };

  home-manager.users.meeri = { pkgs, ... }: {
    home.stateVersion = "22.11";

    # xdg.mimeApps.associations.added = {
    #   "text/plain" = "GVim.desktop";
    # };

    xdg.mimeApps = {
      # enable = true;

      defaultApplications = {
        "image/png" = "feh.desktop";
        "image/jpeg" = "feh.desktop";
        "text/plain" = "GVim.desktop";
      };
    };
  };
}
