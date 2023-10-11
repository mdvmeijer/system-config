{ config, pkgs, ... }:

{
  imports =
    [
      ./vim.nix
      ./python.nix
      ./vscode.nix
      ./mullvad-vpn.nix
      ./kdeconnect.nix
      ./virtualization.nix
      ./tailscale.nix
      ./usb-automount/default.nix

      ./hyprland.nix
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
    zip
    unzip
    texlive.combined.scheme-full  # LaTeX stuff
    powertop
    easyeffects  # Fix FW speakers

    firefox
    tor-browser-bundle-bin
    mullvad-browser
    brave
    google-chrome

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

    #
    eva  # bc alternative (calculator)
    du-dust  # du alternative
    duf  # df alternative
    zoxide  # cd alternative
    tokei  # Enumerate code files
    fd  # find alternative
    
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
    rhythmbox
    emacs

    clang
    gcc
    gdb
    bintools

    cmatrix
    ripgrep
    neovim

    genact

    gwenview

    element-desktop
    fractal
    remmina
    testdisk  # Data recovery
    libguestfs  # For accessing VHDx files
    gparted
    ventoy-full
    nmap

    rpi-imager

    simple-mtpfs  # To transfer files to/from Android phone
    graphviz  # To generate org-roam graphs
    psmisc  # For fuser command
    nodePackages.pnpm
    rustup
    direnv
    lsof
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
    agave
    iosevka
    roboto-mono
    jetbrains-mono
    font-awesome  # for waybar icons
    overpass
    paratype-pt-serif
    emacs-all-the-icons-fonts
  ];
}
