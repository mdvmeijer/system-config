args@{ config, pkgs, lib, username-work, ... }:

let
  username = "${username-work}";
  args-with-username = (args // { inherit username; });
in {
  imports = [
    (import ./core/default.nix args-with-username)

    (import ./themes/catppuccin/macchiato-rosewater.nix args-with-username)
  ];

  users.users.${username} = {
    isNormalUser = true;
    description = "MYP";
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      "kvm"
      "mlocate"
    ];
    initialPassword = "password";
  };

  home-manager.users.${username} = { pkgs, ... }: {
    home.stateVersion = "22.11";

    home.packages = with pkgs; [
      android-studio
      slack
      yubikey-manager-qt
      yubikey-manager
    ];

    programs.git = {
      enable = true;

      userName = "M.D.V. Meijer";
      userEmail = "max.meijer@mindyourpass.com";

      aliases = {
        ci = "commit";
        co = "checkout";
        s = "status";
      };
    };
  };
}
