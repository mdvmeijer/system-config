{ config, pkgs, inputs, lib, username-main, ... }:

let
  select-power-profile = pkgs.writeShellScriptBin "select-power-profile" (builtins.readFile ./scripts/power-management/select-power-profile);
  set-powersave-profile = pkgs.writeShellScriptBin "set-powersave-profile" (builtins.readFile ./scripts/power-management/set-powersave-profile);
  set-balanced-profile = pkgs.writeShellScriptBin "set-balanced-profile" (builtins.readFile ./scripts/power-management/set-balanced-profile);
  set-performance-profile = pkgs.writeShellScriptBin "set-performance-profile" (builtins.readFile ./scripts/power-management/set-performance-profile);
  set-extreme-profile = pkgs.writeShellScriptBin "set-extreme-profile" (builtins.readFile ./scripts/power-management/set-extreme-profile);

  taskell-manager = pkgs.writeShellScriptBin "taskell-manager" (builtins.readFile ../../scripts/fzf/taskell-manager.sh);
  system-config-file-opener = pkgs.writeShellScriptBin "system-config-file-opener" (builtins.readFile ../../scripts/fzf/system-config-file-opener.sh);
  wofi-key-value-store = pkgs.writeShellScriptBin "wofi-key-value-store" (builtins.readFile ../../scripts/wofi/wofi-key-value-store.sh);

  enable-internal-monitor = pkgs.writeShellScriptBin "enable-internal-monitor" (builtins.readFile ./scripts/monitor-selection/enable-internal-monitor.sh);
  disable-internal-monitor = pkgs.writeShellScriptBin "disable-internal-monitor" (builtins.readFile ./scripts/monitor-selection/disable-internal-monitor.sh);
in
{
  imports =
    [
      ./hardware-configuration.nix
      ./no-git.nix
    ];

  boot.kernelParams = [
    # For Power consumption
    # https://kvark.github.io/linux/framework/2021/10/17/framework-nixos.html
    "mem_sleep_default=deep"
    # disabling psr (panel self-refresh rate) as workaround for iGPU hangs
    # https://discourse.nixos.org/t/intel-12th-gen-igpu-freezes/21768/4
    "i915.enable_psr=1"

    # sensor hub module conflicts with manual brightness adjustment
    "module_blacklist=hid_sensor_hub"
  ];

  # services.fw-fanctrl.enable = true;
  # services.fw-fanctrl.configJsonPath = /home/meeri/Projects/fw-fanctrl/fw-fanctrl-nix/config.json;

  systemd.services.fw-fanctrl = let
    python = pkgs.python3.withPackages (ps: with ps; [ watchdog ]);
    script = ./. + "/fw-fanctrl/fw-fanctrl"; # Note this is a path, not a string
    config = ./. + "/fw-fanctrl/config.json";
  in {
    serviceConfig = {
      ExecStart = "${python.interpreter} ${script} --config ${config} --no-log";
    };
    enable = true;
    description = "Framework fan controller";
    wantedBy = [ "multi-user.target" ];
    after = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      Restart = "always";
    };
  };

  systemd.services.fw-power-profile = let
    command = "${set-balanced-profile}/bin/set-balanced-profile";
  in {
    serviceConfig = {
      ExecStart = "${pkgs.bash}/bin/bash ${command}";
    };
    enable = true;
    description = "Sets CPU power profile";
    wantedBy = [ "multi-user.target" ];
    after = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
    };
  };

  meeriModules.hyprland = {
    monitorConfig = ''
      # Config for 3440x1440 monitor
      # monitor=eDP-1, 2256x1504, 0x0, 1.25
      # monitor=DP-3, 3440x1440@144, 1504x-237, 1.00
      # workspace=1,monitor:DP-3  # Bind workspace 1 to external monitor

      # Work config for 3440x1440 monitor
      # monitor=eDP-1, 2256x1504, 0x0, 1.25
      # monitor=DP-3, 3440x1440@60, -800x-1440, 1.00
      # workspace=1,monitor:eDP-1  # Bind workspace 1 to external monitor
      # workspace=2,monitor:DP-3  # Bind workspace 1 to external monitor

      # Config for 1920x1080 monitor
      monitor=eDP-1, 2256x1504, 0x0, 1.25
      monitor=DP-1, 1920x1080, -60x-1080, 1.00
    '';
  };

  environment.systemPackages = with pkgs; [
    fw-ectool
    intel-gpu-tools  # for verifying HW acceleration with intel_gpu_top

    # scripts
    select-power-profile
    set-powersave-profile
    set-balanced-profile
    set-performance-profile
    set-extreme-profile

    taskell-manager
    system-config-file-opener
    wofi-key-value-store

    enable-internal-monitor
    disable-internal-monitor
  ];

  security.sudo.extraRules = [
    {  
      users = [ "${username-main}" ];
      commands = [
        { 
          command = "${set-powersave-profile}/bin/set-powersave-profile";
          options= [ "NOPASSWD" ]; # "SETENV" # Adding the following could be a good idea
        }
        {
          command = "${set-balanced-profile}/bin/set-balanced-profile";
          options= [ "NOPASSWD" ]; # "SETENV" # Adding the following could be a good idea
        }
        {
          command = "${set-performance-profile}/bin/set-performance-profile";
          options= [ "NOPASSWD" ]; # "SETENV" # Adding the following could be a good idea
        }
        {
          command = "${set-extreme-profile}/bin/set-extreme-profile";
          options= [ "NOPASSWD" ]; # "SETENV" # Adding the following could be a good idea
        }
      ];
    }
  ]; 

  ######### Core system stuff #########

  boot.kernelPackages = pkgs.linuxPackages_latest;

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

  boot.initrd.kernelModules = [ "i915" ];

  environment.variables = {
    VDPAU_DRIVER = lib.mkIf config.hardware.opengl.enable (lib.mkDefault "va_gl");
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    setLdLibraryPath = true;
    extraPackages = with pkgs; [
      vaapiIntel
      libvdpau-va-gl
      intel-media-driver
      mesa
    ];
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

  ######## /Core system stuff ########

  services = {
    fstrim.enable = true;
    thermald.enable = true;
    printing.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    tlp = {
      enable = true;
      settings = {
        # https://community.frame.work/t/guide-linux-battery-life-tuning/6665/204
        INTEL_GPU_MIN_FREQ_ON_AC=100;
        INTEL_GPU_MIN_FREQ_ON_BAT=100;
        INTEL_GPU_MAX_FREQ_ON_AC=1300;
        INTEL_GPU_MAX_FREQ_ON_BAT=450;
        INTEL_GPU_BOOST_FREQ_ON_AC=1300;
        INTEL_GPU_BOOST_FREQ_ON_BAT=450;

        PCIE_ASPM_ON_BAT="powersupersave";
        RUNTIME_PM_ON_BAT=1;

        # Setting USB_AUTOSUSPEND messes with my network adapter
        USB_AUTOSUSPEND=0;
      };
    };
    power-profiles-daemon.enable = false;
  };

  powerManagement.powertop.enable = false;

  networking = {
    hostName = "lateralus";
    networkmanager.enable = true;
    # wireless.enable = true;
    # wireless.userControlled.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        3000 # localhost React server
        8080 # localhost Argon2 server
      ];
    };

    # wireless.networks.eduroam = {
    #   auth = ''
    #     key_mgmt=WPA-EAP
    #     eap=PWD
    #     identity="mameijer@abo.fi"
    #     password="KeazTaYbubzy"
    #   '';
    # };
  };
  ############ /Networking ############

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
