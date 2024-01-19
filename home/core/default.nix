args@{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.meeriModules.mimeApps;
in {
  imports = [
    ./alacritty
    ./bash
    ./bat.nix
    ./tmux

    ./doom-emacs
  ];

  options.meeriModules.mimeApps = {
    defaultBrowser = mkOption {
      type = types.str;
      default = "firefox.desktop";
      example = "chromium.desktop";
      description = "*.desktop file of the desired default browser.";
    };
  };

  config = {
    programs.obs-studio.enable = true;
    programs.eza.enable = true;

    programs.zathura = {
      enable = true;
      options = {
        sandbox = "none";
        selection-clipboard = "clipboard";
      };
    };

    services.batsignal.enable = true; # Battery daemon

    programs.git = {
      enable = true;

      userName = "M.D.V. Meijer";
      userEmail = "mdvmeijer@protonmail.com";

      aliases = {
        ci = "commit";
        co = "checkout";
        s = "status";
        sw = "switch";
        p = "pull";
        f = "fetch";
        d = "diff";
        b = "branch";
        l = "log";
        mg = "merge";
        rb = "rebase";
      };

      extraConfig = {
        push.autoSetupRemote = true;
      };
    };

    xdg.mimeApps = {
      enable = true;

      associations.added = {
        "text/plain" = "vim.desktop";
        "text/html" = "firefox.desktop";
        "application/pdf" = "org.pwmt.zathura-pdf-mupdf.desktop";
        "image/jpeg" = "vimiv.desktop";
        "image/png" = "vimiv.desktop";

        "x-scheme-handler/chrome" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";

        "x-scheme-handler/signalcaptcha" = "signal-desktop.desktop";

        # .docx files
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "writer.desktop";

        # .odt files
        "application/vnd.oasis.opendocument.text" = "writer.desktop";

        "video/mp4" = "mpv.desktop";
        "video/x-matroska" = "mpv.desktop";
      };

      defaultApplications = {
        "text/plain" = "vim.desktop";
        "text/html" = "firefox.desktop";
        "application/pdf" = "org.pwmt.zathura-pdf-mupdf.desktop";
        "image/jpeg" = "vimiv.desktop";
        "image/png" = "vimiv.desktop";

        "x-scheme-handler/chrome" = "${cfg.defaultBrowser}";
        "x-scheme-handler/http" = "${cfg.defaultBrowser}";
        "x-scheme-handler/https" = "${cfg.defaultBrowser}";

        "x-scheme-handler/signalcaptcha" = "signal-desktop.desktop";

        # .docx files
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "writer.desktop";

        # .odt files
        "application/vnd.oasis.opendocument.text" = "writer.desktop";

        "video/mp4" = "mpv.desktop";
        "video/x-matroska" = "mpv.desktop";
      };
    };
  };
}
