{ config, pkgs, ... }:

{
  imports =
    [
      ./main-user.nix

      ./bash.nix
      ./vim.nix
      ./python.nix
      ./vscode.nix
      ./mullvad-vpn.nix
      ./tmux.nix
      ./alacritty.nix
      ./kdeconnect.nix
      ./bat.nix
      ./git.nix
      ./zathura.nix
      ./exa.nix  # ls alternative
    ];

  environment.sessionVariables = rec {
    XDG_CACHE_HOME  = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME   = "$HOME/.local/share";
    XDG_STATE_HOME  = "$HOME/.local/state";

    # Not officially in the specification
    #XDG_BIN_HOME    = "$HOME/.local/bin";
    #PATH = [
    #  "${XDG_BIN_HOME}"
    #];
  };

  environment.systemPackages = with pkgs; [
    wget
    discord
    nodejs
    vlc
    libreoffice-qt
    openssl
    ffmpeg
    htop
    glances
    qbittorrent
    mlocate
    wofi
    chromium
    unzip
    powertop
    easyeffects  # Fix FW speakers

    google-chrome
    firefox
    tor-browser-bundle-bin
    mullvad-browser

    killall
    lm_sensors
    galaxy-buds-client
    spotify
    smartmontools  # Get SMART data
    obsidian
    nicotine-plus
    gimp
    zola
    lf
    file
    feh
    konsole
    zsh

    # Nice utils written in Rust
    eva  # bc alternative (calculator)
    du-dust  # du alternative
    duf  # df alternative
    zoxide  # cd alternative
    tokei  # Enumerate code files
    
    # TODO: Rust tools to check out
    # TODO: https://github.com/ibraheemdev/modern-unix
    # hexyl  # hex viewer
    # nomino  # batch renaming
    # sd  # string find+replace tool; sed alternative?

    # PDF utils
    ocrmypdf  # Add OCR layer to PDF file
    qpdf  # e.g. rotating, splitting, merging, encryption

    tldr
    libnotify
    youtube-dl
    signal-desktop
    whatsapp-for-linux
    electron-mail
    tmuxinator  # TODO: maybe delete
    mpv
    neofetch
    tmux
    fzf
    speedtest-cli
    calibre
    taskell  # CLI kanban board
    calcurse  # TUI calendar
    termdown  # terminal countdown timer
    espeak-classic  # speech synthesizer

    gcc
    gdb
    bintools

    emacs
    cmatrix
    ripgrep
    neovim

    genact
    geeqie

    rhythmbox
  ];


  programs.dconf.enable = true;

  services.locate = {
    enable = true;
    locate = pkgs.mlocate;
    interval = "daily";
    # warning: mlocate and plocate do not support the services.locate.localuser option. updatedb will run as root. Silence this warning by setting services.locate.localuser = null
    localuser = null;
  };

  nixpkgs.overlays = [
    (final: prev: {
      # discord package from nixpkgs is outdated: it prompts for an update and is otherwise unusable
      discord = prev.discord.overrideAttrs (
        _: { src = builtins.fetchTarball {
          url =
          "https://discord.com/api/download?platform=linux&format=tar.gz";
          sha256 = "087p8z538cyfa9phd4nvzjrvx4s9952jz1azb2k8g6pggh1vxwm8";
        }; }
      );
    })
  ];

  fonts.fonts = with pkgs; [
    iosevka
    agave
    font-awesome  # for waybar icons
  ];
}
