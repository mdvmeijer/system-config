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

    xdg.mimeApps = {
      enable = true;

      associations.added = {
        "text/plain" = "vim.desktop";
        "application/pdf" = "org.pwmt.zathura-pdf-mupdf.desktop";
        "image/jpeg" = "org.kde.gwenview.desktop";
        "image/png" = "org.kde.gwenview.desktop";

        "x-scheme-handler/chrome" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";

        "x-scheme-handler/signalcaptcha" = "signal-desktop.desktop";
      };

      defaultApplications = {
        "text/plain" = "vim.desktop";
        "application/pdf" = "org.pwmt.zathura-pdf-mupdf.desktop";
        "image/jpeg" = "org.kde.gwenview.desktop";
        "image/png" = "org.kde.gwenview.desktop";

        "x-scheme-handler/chrome" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";

        "x-scheme-handler/signalcaptcha" = "signal-desktop.desktop";
      };
    };
  };
}
