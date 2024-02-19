{ config, pkgs, ... }:

let
  system-config-file-opener = pkgs.writeShellScriptBin "system-config-file-opener" (builtins.readFile ../../scripts/fzf/system-config-file-opener.sh);
  wofi-key-value-store = pkgs.writeShellScriptBin "wofi-key-value-store" (builtins.readFile ../../scripts/wofi/wofi-key-value-store.sh);
in
{
  imports =
    [
      ./vim.nix
      ./python.nix
      ./vscode.nix
      ./mullvad-vpn.nix
      ./virtualization.nix
      ./tailscale.nix
    ];

  users.users.meeri = {
    isNormalUser = true;
    description = "Max Meijer";
    extraGroups = [ 
      "networkmanager"
      "wheel"
      "libvirtd"
      "kvm"
      "mlocate"
      "dialout"  # Access to serial ports, e.g. for Arduino
      "plugdev"
      "adbusers"
    ];
    initialPassword = "password";
  };

  users.groups.plugdev = {};

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
    system-config-file-opener
    wofi-key-value-store

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
    zip
    unzip
    texlive.combined.scheme-full  # LaTeX stuff
    powertop
    easyeffects  # Fix FW speakers

    firefox
    tor-browser-bundle-bin
    mullvad-browser
    google-chrome

    killall
    lm_sensors
    spotify
    smartmontools  # Get SMART data
    obsidian
    nicotine-plus
    gimp
    zola
    file
    feh
    konsole
    zsh

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
    mpv
    neofetch
    tmux
    fzf
    speedtest-cli
    calibre
    # taskell  # CLI kanban board
    calcurse  # TUI calendar
    termdown  # terminal countdown timer
    espeak-classic  # speech synthesizer
    rhythmbox
    emacs

    clang
    gcc
    gdb
    bintools

    ripgrep
    neovim

    cmatrix
    genact

    element-desktop
    # fractal
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

    jetbrains.rust-rover
    gnuradio
    android-tools  # fastboot, adb
    scrcpy  # Mirror phone screen

    cifs-utils
    nix-index
  ];

  security.polkit.enable = true;
  programs.dconf.enable = true;
  services.udisks2.enable = true;
  programs.adb.enable = true;
  services.fwupd.enable = true;

  services.locate = {
    enable = true;
    package = pkgs.mlocate;
    interval = "daily";
    # warning: mlocate and plocate do not support the services.locate.localuser option. updatedb will run as root. Silence this warning by setting services.locate.localuser = null
    localuser = null;
  };

  fonts.packages = with pkgs; [
    agave
    iosevka
    roboto-mono
    jetbrains-mono
    font-awesome  # for waybar icons
    overpass
    paratype-pt-serif
    emacs-all-the-icons-fonts
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
    settings = {
      auto-optimise-store = true;
    };
  };
}
