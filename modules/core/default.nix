{ config, pkgs, username-main, ... }:

let
  system-config-file-opener = pkgs.writeShellScriptBin "system-config-file-opener" (builtins.readFile ../../scripts/fzf/system-config-file-opener.sh);
  # wofi-key-value-store = pkgs.writeShellScriptBin "wofi-key-value-store" (builtins.readFile ../../scripts/wofi/wofi-key-value-store.sh);

#   enable-internal-monitor = pkgs.writeShellScriptBin "enable-internal-monitor" (builtins.readFile ./scripts/monitor-selection/enable-internal-monitor.sh);
#   disable-internal-monitor = pkgs.writeShellScriptBin "disable-internal-monitor" (builtins.readFile ./scripts/monitor-selection/disable-internal-monitor.sh);
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

      ./hyprland.nix
    ];

  users.users.${username-main} = {
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
    google-chrome

    killall
    lm_sensors
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
    polkit_gnome

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

    gwenview

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
    udiskie  # Auto mount external drives

    jetbrains.rust-rover
    gnuradio
    android-tools  # fastboot, adb
    scrcpy  # Mirror phone screen
  ];

  security.polkit.enable = true;

  programs.dconf.enable = true;

  services.udisks2.enable = true;

  services.locate = {
    enable = true;
    package = pkgs.mlocate;
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
          sha256 = "1091nv1lwqlcs890vcil8frx6j87n4mig1xdrfxi606cxkfirfbh";
        }; }
      );
    })
  ];

  fonts.packages = with pkgs; [
    agave
    iosevka
    roboto-mono
    jetbrains-mono
    font-awesome  # for waybar icons
    overpass
    paratype-pt-serif
    emacs-all-the-icons-fonts
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