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
    ./lf

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
    home.homeDirectory = "/home/meeri";

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
        dc = "diff --cached";
        b = "branch";
        l = "log";
        mg = "merge";
        rb = "rebase";
        cp = "cherry-pick";
        res = "restore";
        resta = "restore --staged";

        branches = "branch -a";
        remotes = "remote -v";
        tags = "tag -l";
      };

      extraConfig = {
        push.autoSetupRemote = true;
        init.defaultBranch = "main";
      };
    };

    xdg.userDirs = {
      enable = true;

      desktop = "${config.home.homeDirectory}/desktop";
      documents = "${config.home.homeDirectory}/documents";
      download = "${config.home.homeDirectory}/downloads";
      music = "${config.home.homeDirectory}/music";
      pictures = "${config.home.homeDirectory}/pictures";
      publicShare = "${config.home.homeDirectory}/public";
      templates = "${config.home.homeDirectory}/templates";
      videos = "${config.home.homeDirectory}/videos";
    };

    xdg.mimeApps = {
      enable = true;

      associations.added = {
        "text/plain" = "vim.desktop";
        "text/html" = "firefox.desktop";
        "application/pdf" = "org.pwmt.zathura-pdf-mupdf.desktop";
        "image/jpeg" = "vimiv.desktop";
        "image/png" = "vimiv.desktop";

        "inode/directory" = "org.gnome.Nautilus.desktop";

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

        "inode/directory" = "org.gnome.Nautilus.desktop";

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

    # Declaratively set QEMU connection for virt-manager
    dconf.settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = ["qemu:///system"];
        uris = ["qemu:///system"];
      };
    };
  };
}
