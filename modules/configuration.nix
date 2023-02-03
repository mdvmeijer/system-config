# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  mainUser="meeri";
  workUser="max";
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./vim.nix
      ./python.nix
      ./vscode.nix
      #<home-manager/nixos>
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  ##### edited by meeri
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "module_blacklist=hid_sensor_hub" ];
  boot.supportedFilesystems = [ "ntfs" ];
  hardware.bluetooth.enable = true;

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

  services.thermald.enable = true;
  powerManagement.powertop.enable = true;
  # services.power-profiles-daemon.enable = false;
  # services.tlp.enable = true;

  # systemd.services.fw-fanctrl = {
  #   enable = true;
  #   description = "Framework fan controller";
  #   after = [ "default.target" ];
  #   wantedBy = [ "default.target" ];
  #   unitConfig = {
  #     Type = "simple";
  #   };
  #   serviceConfig = {
  #     # ExecStart = "${pkgs.python3}/bin/python3 /home/meeri/bin/fw-fanctrl --config /home/meeri/.config/fw-fanctrl/config.json --no-log";
  #     ExecStart = "${pkgs.bash}/bin/bash /home/meeri/bin/fw-fanctrl-autostart";
  #   };
  # };

  services.locate = {
    enable = true;
    locate = pkgs.mlocate;
    interval = "daily";
    # warning: mlocate and plocate do not support the services.locate.localuser option. updatedb will run as root. Silence this warning by setting services.locate.localuser = null
    localuser = null;
  };

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  virtualisation.libvirtd.enable = true;

  # make sure eduroam works
  networking.wireless.iwd.enable = true;
  networking.networkmanager.wifi.backend = "iwd";
  services.connman.wifi.backend = "iwd"; # maybe can be removed?

  # mullvad
  networking.firewall.checkReversePath = "loose";
  networking.wireguard.enable = true;
  services.mullvad-vpn.enable = true;

  #environment.etc."vimrc".source = /home/meeri/.vimrc;

  fonts.fonts = with pkgs; [
    iosevka
    agave
  ];
  #####################

  # Enable swap on luks
  boot.initrd.luks.devices."luks-dffaa50a-c064-4595-b099-ee9812816276".device = "/dev/disk/by-uuid/dffaa50a-c064-4595-b099-ee9812816276";
  boot.initrd.luks.devices."luks-dffaa50a-c064-4595-b099-ee9812816276".keyFile = "/crypto_keyfile.bin";

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Helsinki";

  # Select internationalisation properties.
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

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    ${mainUser} = {
      isNormalUser = true;
      description = "Max Meijer";
      extraGroups = [ "networkmanager" "wheel" "libvirtd" "mlocate" ];
      initialPassword = "password";
    };
    ${workUser} = {
      isNormalUser = true;
      description = "MYP";
      extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
      initialPassword = "password";
    };
  };

  # Allow unfree packages
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
    virt-manager
    yakuake
    # kamoso (using nix-env atm) 
    killall
    google-chrome
    lm_sensors
    (import /home/meeri/framework/fw-ectool/default.nix)
  ];

  environment.sessionVariables = {
    DOTNET_ROOT = "${pkgs.dotnet-sdk}";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  networking.firewall = { 
    enable = true;
    allowedTCPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
    allowedUDPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  nixpkgs.overlays = [
    (self: super: {
      discord = super.discord.overrideAttrs (
        _: { src = builtins.fetchTarball {
          url =
          "https://discord.com/api/download?platform=linux&format=tar.gz";
          sha256 = "087p8z538cyfa9phd4nvzjrvx4s9952jz1azb2k8g6pggh1vxwm8";
        }; }
      );
    })
  ];

  home-manager.users.${workUser} = { pkgs, ... }: {
    home.stateVersion = "22.11";
    nixpkgs.config.allowUnfree = true;

    home.packages = with pkgs; [
      android-studio
      slack
    ];

    home.file.".bash_aliases".source = "/home/meeri/config-sync/.bash_aliases";
    home.file.".bashrc".source = "/home/meeri/config-sync/.bashrc";
    home.file.".tmux.conf".source = "/home/meeri/config-sync/.tmux.conf";
    home.file.".alacritty.yml".source = "/home/meeri/config-sync/.alacritty.yml";
  };

  home-manager.users.${mainUser} = { pkgs, ... }: {
    home.stateVersion = "22.11";

    home.file.".bash_aliases".source = "/home/meeri/config-sync/.bash_aliases";
    home.file.".bashrc".source = "/home/meeri/config-sync/.bashrc";
    home.file.".tmux.conf".source = "/home/meeri/config-sync/.tmux.conf";
    home.file.".alacritty.yml".source = "/home/meeri/config-sync/.alacritty.yml";
  };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

}
