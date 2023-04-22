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
    ];

  environment.systemPackages = with pkgs; [
    wget
    git
    firefox
    kate
    discord
    nodejs
    vlc
    libreoffice-qt
    openssl
    ffmpeg
    htop
    glances
    qbittorrent
    dotnet-sdk # for dafny course
    mlocate
    wofi
    chromium
    unzip
    powertop
    easyeffects

    yakuake
    # kamoso (using nix-env atm)
    killall
    google-chrome
    lm_sensors
    galaxy-buds-client
    spotify
    smartmontools
    bat
    obsidian
    nicotine-plus
    gimp
    zola
    lf
    file
    feh

    # PDF utils
    ocrmypdf  # Add OCR layer to PDF file
    qpdf  # e.g. rotating, splitting, merging, encryption

    tldr
    zathura
    libnotify
    youtube-dl
    signal-desktop
    tmuxinator
    mpv
    neofetch
    tmux
    fzf
    speedtest-cli
    calibre
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
