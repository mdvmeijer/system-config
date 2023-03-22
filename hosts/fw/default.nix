{ config, pkgs, inputs, ... }:

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
      # /home/meeri/temp/fw-fanctrl-nix/service.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.xserver.videoDrivers = [ "modesetting" ];
  boot.kernelParams = [
    # disabling psr (panel self-refresh rate) as workaround for iGPU hangs
    # https://discourse.nixos.org/t/intel-12th-gen-igpu-freezes/21768/4
    # NOTE: Instead of setting the option to 1 as in the linked forum topic,
    # setting it to 0 in combination with the 'modesetting' driver seems to fix the problem for me.
    "i915.enable_psr=0"

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

    # Setting USB_AUTOSUSPEND messes with my network adapter
    USB_AUTOSUSPEND=0;
  };


  networking.hostName = "nixos";

  # make sure eduroam works
  networking.wireless.iwd.enable = true;
  networking.wireless.enable = false;
  networking.networkmanager.wifi.backend = "iwd";
  # services.connman.wifi.backend = "iwd"; # maybe can be removed?


  environment.systemPackages = with pkgs; [
    fw-ectool
    intel-gpu-tools  # for verifying HW acceleration with intel_gpu_top

    # scripts
    select-power-profile
    set-powersave-profile
    set-balanced-profile
    set-performance-profile
    set-extreme-profile
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
}
