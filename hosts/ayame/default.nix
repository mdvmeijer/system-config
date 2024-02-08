# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelParams = [
    "mem_sleep_default=deep"
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "ayame";
  hardware.bluetooth.enable = true;

  home-manager.users.meeri = {
    meeriModules.hyprland = {
      monitorConfig = ''
        # Config for 3440x1440 monitor
        # monitor=eDP-1, 1920x1080, 0x0, 1.00
        # monitor=HDMI-A-1, 3440x1440@144, 1920x0, 1.00
        # workspace=1,monitor:HDMI-A-1  # Bind workspace 1 to external monitor

        # Work config for 3440x1440 monitor
        monitor=eDP-1, 1920x1080, 0x0, 1.00
        monitor=HDMI-A-1, 3440x1440@60, -800x-1440, 1.00
        workspace=1,monitor:eDP-1  # Bind workspace 1 to external monitor
        workspace=2,monitor:HDMI-A-1  # Bind workspace 2 to external monitor

        # Config for 1920x1080 monitor
        # monitor=eDP-1, 1920x1080, 0x0, 1.00
        # monitor=HDMI-A-1, 1920x1080, 0x-1080, 1.00
      '';
    };

    services.easyeffects = {
      enable = true;
      preset = "Advanced Auto Gain";
    };
  };

  home-manager.users.meeri.meeriModules.mimeApps = {
    defaultBrowser = "chromium.desktop";
  };

  environment.systemPackages = with pkgs; [
    intel-gpu-tools
  ];

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

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

  # Enable CUPS to print documents.
  services.printing.enable = true;

  fileSystems."/mnt/media" = {
      device = "//100.78.70.68/media";
      fsType = "cifs";
      options = let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in ["${automount_opts},credentials=/etc/nixos/smb-secrets"];
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  boot.initrd.kernelModules = [ "i915" ];

  environment.variables = {
    VDPAU_DRIVER = lib.mkIf config.hardware.opengl.enable (lib.mkDefault "va_gl");
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    # Setting the LD_LIBRARY_PATH globally like this in NixOS can cause problems, e.g. with nodejs
    # setLdLibraryPath = true;
    extraPackages = with pkgs; [
      vaapiIntel
      libvdpau-va-gl
      intel-media-driver
      mesa
      mesa.drivers
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}

