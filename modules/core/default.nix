{ config, pkgs, ... }:

let
  system-config-file-opener = pkgs.writeShellScriptBin "system-config-file-opener" (builtins.readFile ../../scripts/fzf/system-config-file-opener.sh);
  wofi-key-value-store = pkgs.writeShellScriptBin "wofi-key-value-store" (builtins.readFile ../../scripts/wofi/wofi-key-value-store.sh);
  audio-sink-switcher = pkgs.writeShellScriptBin "audio-sink-switcher" (builtins.readFile ../../scripts/rofi/audio-sink-switcher.sh);
in
{
  imports =
    [
      ./vim.nix
      ./python.nix
      ./vscode.nix
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

    PATH = [
      "$HOME/.emacs.d/bin"
    ];
  };

  environment.systemPackages = with pkgs; [
    system-config-file-opener
    wofi-key-value-store
    audio-sink-switcher

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
    powertop
    easyeffects  # Fix FW speakers
    sshfs

    firefox
    tor-browser-bundle-bin
    mullvad-browser
    google-chrome

    killall
    lm_sensors
    spotify
    smartmontools  # Get SMART data
    nicotine-plus
    gimp
    zola
    file
    feh
    konsole
    zsh
    tree

    eva  # bc alternative (calculator)
    du-dust  # du alternative
    duf  # df alternative
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
    yt-dlp
    signal-desktop
    mpv
    neofetch
    tmux
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
    exfat

    simple-mtpfs  # To transfer files to/from Android phone
    graphviz  # To generate org-roam graphs
    psmisc  # For fuser command
    nodePackages.pnpm
    bun
    rustup
    lsof

    jetbrains.rust-rover
    android-tools  # fastboot, adb
    scrcpy  # Mirror phone screen

    cifs-utils
    nix-index
    protonmail-desktop
    matlab
    wayvnc
  ];

  security.polkit.enable = true;
  programs.dconf.enable = true;
  services.udisks2.enable = true;
  programs.adb.enable = true;
  services.fwupd.enable = true;
  
  services.upower.enable = true;

  boot.supportedFilesystems = [ "ntfs" ];

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
    nerdfonts
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
