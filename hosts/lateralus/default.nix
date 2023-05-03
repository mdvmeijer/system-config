{ config, pkgs, inputs, lib, ... }:

let
  select-power-profile = pkgs.writeShellScriptBin "select-power-profile" (builtins.readFile ./scripts/power-management/select-power-profile);
  set-powersave-profile = pkgs.writeShellScriptBin "set-powersave-profile" (builtins.readFile ./scripts/power-management/set-powersave-profile);
  set-balanced-profile = pkgs.writeShellScriptBin "set-balanced-profile" (builtins.readFile ./scripts/power-management/set-balanced-profile);
  set-performance-profile = pkgs.writeShellScriptBin "set-performance-profile" (builtins.readFile ./scripts/power-management/set-performance-profile);
  set-extreme-profile = pkgs.writeShellScriptBin "set-extreme-profile" (builtins.readFile ./scripts/power-management/set-extreme-profile);
in
{
  imports =
    [
      ./hardware-configuration.nix
      ./no-git.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.xserver.videoDrivers = [ "modesetting" ];
  boot.kernelParams = [
    # disabling psr (panel self-refresh rate) as workaround for iGPU hangs
    # https://discourse.nixos.org/t/intel-12th-gen-igpu-freezes/21768/4
    # NOTE: Instead of setting the option to 1 as in the linked forum topic,
    # setting it to 0 in combination with the 'modesetting' driver seems to fix the problem for me.
    "i915.enable_psr=0"
    # "i915.force_probe=46a6"

    # sensor hub module conflicts with manual brightness adjustment
    "module_blacklist=hid_sensor_hub"
  ];

  # For fingerprint support
  # NOTE: breaks startup login on KDE
  # services.fprintd.enable = lib.mkDefault true;

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

  # powertop --auto-tune and ppd conflict with tlp
  powerManagement.powertop.enable = false;
  services.power-profiles-daemon.enable = false;

  services.tlp.enable = true;
  services.tlp.settings = {
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


  environment.systemPackages = with pkgs; [
    fw-ectool
    intel-gpu-tools  # for verifying HW acceleration with intel_gpu_top

    # scripts
    select-power-profile
    set-powersave-profile
    set-balanced-profile
    set-performance-profile
    set-extreme-profile

    dhcpcd  # eduroam
  ];

  security.sudo.extraRules = [
    {  
      users = [ "meeri" ];
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

  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    setLdLibraryPath = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      mesa
    ];
  };

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
  services.xserver.displayManager.defaultSession = "hyprland";
  # services.xserver.desktopManager.plasma5.enable = true;

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

  ############# /Services #############


  ############# Networking ############

  networking.hostName = "lateralus";

  # Enable networking
  networking.networkmanager.enable = true;
  # networking.networkmanager.dhcp = "dhcpcd";

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      3000 # localhost React server
      8080 # localhost Argon2 server
    ];
  };

  ############ /Networking ############


  ######### Users & packages ##########

  # why doesn't this work?
  # environment.etc."inputrc".source = ./. + "/dotfiles/nixos-inputrc";
  # environment.etc."inputrc".source = /home/meeri/.system-config/dotfiles/nixos-inputrc;

  ######### /Users & packages ##########

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
