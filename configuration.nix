# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

let
  mainUser="meeri";
  workUser="max";
  modules="/modules";
  dotfiles="/dotfiles";
  hosts="/hosts";
in
{
  imports =
    [
      (./. + "${modules}/hardware-configuration.nix")
      (./. + "${hosts}/framework-laptop/framework-laptop.nix")
      (./. + "${modules}/vim.nix")
      (./. + "${modules}/python.nix")
      (./. + "${modules}/vscode.nix")
    ];

  ######### Core system stuff #########

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-dffaa50a-c064-4595-b099-ee9812816276".device = "/dev/disk/by-uuid/dffaa50a-c064-4595-b099-ee9812816276";
  boot.initrd.luks.devices."luks-dffaa50a-c064-4595-b099-ee9812816276".keyFile = "/crypto_keyfile.bin";

  boot.supportedFilesystems = [ "ntfs" ];
  hardware.bluetooth.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  time.timeZone = "Europe/Helsinki";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };

  ######## /Core system stuff ########


  ############# Services ##############

  services.fstrim.enable = true;

  services.thermald.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.locate = {
    enable = true;
    locate = pkgs.mlocate;
    interval = "daily";
    # warning: mlocate and plocate do not support the services.locate.localuser option. updatedb will run as root. Silence this warning by setting services.locate.localuser = null
    localuser = null;
  };

  services.mullvad-vpn.enable = true;

  ############# /Services #############


  ############# Networking ############

  # Enable networking
  networking.networkmanager.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      3000 # localhost React server
    ];
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect
    ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect
    ];
  };

  # mullvad
  networking.firewall.checkReversePath = "loose";
  networking.wireguard.enable = true;

  ############ /Networking ############


  ######### Users & packages ##########

  # Don't forget to set a password with ‘passwd’.
  users.users = {
    ${mainUser} = {
      isNormalUser = true;
      description = "Max Meijer";
      extraGroups = [ "networkmanager" "wheel" "libvirtd" "kvm" "mlocate" ];
      initialPassword = "password";
    };
    ${workUser} = {
      isNormalUser = true;
      description = "MYP";
      extraGroups = [ "networkmanager" "wheel" "libvirtd" "kvm" "mlocate" ];
      initialPassword = "password";
    };
  };

  home-manager.users.${mainUser} = { pkgs, ... }: {
    home.stateVersion = "22.11";

    home.packages = with pkgs; [
      lutris
      legendary-gl
    ];

    home.file.".bash_aliases".source = ./. + "${dotfiles}/.bash_aliases";
    home.file.".bashrc".source = ./. + "${dotfiles}/.bashrc";
    home.file.".tmux.conf".source = ./. + "${dotfiles}/.tmux.conf";
    home.file.".alacritty.yml".source = ./. + "${dotfiles}/.alacritty.yml";
  };

  home-manager.users.${workUser} = { pkgs, ... }: {
    home.stateVersion = "22.11";
    nixpkgs.config.allowUnfree = true;

    home.packages = with pkgs; [
      android-studio
      slack
      yubikey-manager-qt
      yubikey-manager
      jetbrains.rider
    ];

    home.file.".bash_aliases".source = ./. + "${dotfiles}/.bash_aliases";
    home.file.".bashrc".source = ./. + "${dotfiles}/.bashrc";
    home.file.".tmux.conf".source = ./. + "${dotfiles}/.tmux.conf";
    home.file.".alacritty.yml".source = ./. + "${dotfiles}/.alacritty.yml";
  };

  nixpkgs.config.allowUnfree = true;

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
    alacritty
    kdeconnect
    htop
    qbittorrent
    dotnet-sdk # for dafny course
    mlocate
    rofi
    chromium
    unzip
    powertop
    easyeffects

    # TODO: include in virtualization module
    virt-manager

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
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  programs.dconf.enable = true;

  programs.tmux = {
    enable = true;
    clock24 = true;
  };

  nixpkgs.overlays = [
    (self: super: {
      # discord package from nixpkgs is outdated: it prompts for an update and is otherwise unusable
      discord = super.discord.overrideAttrs (
        _: { src = builtins.fetchTarball {
          url =
          "https://discord.com/api/download?platform=linux&format=tar.gz";
          sha256 = "087p8z538cyfa9phd4nvzjrvx4s9952jz1azb2k8g6pggh1vxwm8";
        }; }
      );
    })
  ];

  ######### /Users & packages ##########


  # dafny / VSCode TODO: Check if needed
  environment.sessionVariables = {
    DOTNET_ROOT = "${pkgs.dotnet-sdk}";
  };

  fonts.fonts = with pkgs; [
    iosevka
    agave
  ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";

    # cachix for nixos-gaming
    settings = {
      substituters = [ "https://nix-gaming.cachix.org" ];
      trusted-public-keys = [ "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
