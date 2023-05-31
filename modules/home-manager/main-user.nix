args@{ config, pkgs, lib, username-main, ... }:

let
  username = "${username-main}";
  args-with-username = (args // { inherit username; });
in {
  imports = [
    (import ./core/default.nix args-with-username)

    (import ./extra/obs.nix args-with-username)
    (import ./extra/qutebrowser.nix args-with-username)
    (import ./extra/gaming.nix args-with-username)

    (import ./themes/catppuccin/macchiato-rosewater.nix args-with-username)
  ];

  nixpkgs.config.allowUnfree = true;

  users.users.${username} = {
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

  home-manager.users.${username} = { pkgs, ... }: {
    home.stateVersion = "22.11";

    programs.git = {
      enable = true;

      userName = "M.D.V. Meijer";
      userEmail = "mdvmeijer@protonmail.com";

      aliases = {
        ci = "commit";
        co = "checkout";
        s = "status";
      };
    };

    # TODO: Fix MIME stuff
    # xdg.mimeApps.associations.added = {
    #   "text/plain" = "GVim.desktop";
    # };

    # xdg.mimeApps = {
    #   enable = true;

    #   defaultApplications = {
    #     "image/png" = "feh.desktop";
    #     "image/jpeg" = "feh.desktop";
    #     "text/plain" = "GVim.desktop";
    #   };
    # };
  };
}
