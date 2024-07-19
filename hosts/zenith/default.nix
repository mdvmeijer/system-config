# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  hardware.framework.amd-7040.preventWakeOnAC = true;
  services.logind.lidSwitch = "ignore"; # Make sure logind does not interfere with hyprland lid handler

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.initrd.luks.devices."luks-2003e3bf-9a37-416f-8417-f0fe2b246fea".device = "/dev/disk/by-uuid/2003e3bf-9a37-416f-8417-f0fe2b246fea";
  networking.hostName = "zenith";
  hardware.bluetooth.enable = true;

  home-manager.users.meeri.meeriModules.hyprland = {
    monitorConfig = ''
      monitor=eDP-1, 2256x1504, 0x0, 1.333333

      # Home config for 3440x1440@144 monitor
      monitor=DP-7, 3440x1440@144, -900x-1440, 1.00
      monitor=DP-8, 3440x1440@144, -900x-1440, 1.00
      workspace=1,monitor:eDP-1  # Bind workspace 1 to external monitor
      workspace=2,monitor:DP-8  # Bind workspace 2 to external monitor
      # Yeet current workspace to primary or secondary monitor
      bind = $mainMod ALT, 1, movecurrentworkspacetomonitor, eDP-1
      bind = $mainMod ALT, 2, movecurrentworkspacetomonitor, DP-8

      # Home config for 3840x2160@60 monitor
      # monitor=DP-2, 3840x2160@60, 0x-1080, 2.00
      # workspace=1,monitor:eDP-1  # Bind workspace 1 to external monitor
      # workspace=2,monitor:DP-2  # Bind workspace 2 to external monitor
      # # Yeet current workspace to primary or secondary monitor
      # bind = $mainMod ALT, 1, movecurrentworkspacetomonitor, eDP-1
      # bind = $mainMod ALT, 2, movecurrentworkspacetomonitor, DP-2
    '';
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  networking.networkmanager.enable = true;

  fileSystems."/mnt/media" = {
    device = "//100.78.70.68/media";
    fsType = "cifs";
    options = let
      # this line prevents hanging on network split
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    in ["${automount_opts},credentials=/root/smb-secrets"];
  };

  fileSystems."/mnt/library" = {
    device = "//100.78.70.68/library";
    fsType = "cifs";
    options = let
      # this line prevents hanging on network split
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    in ["${automount_opts},credentials=/root/smb-secrets"];
  };

  time.timeZone = "Europe/Amsterdam";

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

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [
    solaar
    # fw-ectool
  ];

  hardware.logitech.wireless.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
