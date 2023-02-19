# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

let
  mainUser="meeri";
  workUser="max";
  modules="/modules";
  dotfiles="/dotfiles";
  framework-laptop="/framework-laptop";
in
{
  imports =
    [ # Include the results of the hardware scan.
      (./. + "${modules}/hardware-configuration.nix")
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

#   nixpkgs.config.packageOverrides = pkgs: {
#     vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
#   };

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      # vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      #mesa_drivers
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

  # https://www.nixos.wiki/wiki/Lutris
  # hardware.opengl.driSupport32Bit = true;

  ######## /Core system stuff ########


  ##### 12th gen Framework stuff #####

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

  ##### /12th gen Framework stuff #####


  ############# Services ##############
  
  # https://www.reddit.com/r/NixOS/comments/rkwnj3/comment/hpcps99/
  # https://discourse.nixos.org/t/start-python-script-from-systemd-unit/4520/3
  systemd.services.fw-fanctrl = let
    python = pkgs.python3.withPackages (ps: with ps; [ watchdog ]);
    script = ./. + "${framework-laptop}/fw-fanctrl/fw-fanctrl"; # Note this is a path, not a string
    config = ./. + "${framework-laptop}/fw-fanctrl/config.json";
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
    command = ./. + "${framework-laptop}/power-management/set-balanced-profile"; # Note this is a path, not a string
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

  services.fstrim.enable = true;

  services.thermald.enable = true;

  # powertop --auto-tune and ppd conflict with tlp
  powerManagement.powertop.enable = false;
  services.power-profiles-daemon.enable = false;

  # services.auto-cpufreq.enable = true;

  services.tlp.enable = false;
  services.tlp.settings = {
    # https://community.frame.work/t/guide-linux-battery-life-tuning/6665/204
    INTEL_GPU_MIN_FREQ_ON_AC=100;
    INTEL_GPU_MIN_FREQ_ON_BAT=100;
    INTEL_GPU_MAX_FREQ_ON_AC=1300;
    INTEL_GPU_MAX_FREQ_ON_BAT=450;
    INTEL_GPU_BOOST_FREQ_ON_AC=1300;
    INTEL_GPU_BOOST_FREQ_ON_BAT=450;

    # instead of this, manually set RAPL values
    #CPU_ENERGY_PERF_POLICY_ON_AC="balance-performance";
    #CPU_ENERGY_PERF_POLICY_ON_BAT="balance-performance";

    PCIE_ASPM_ON_BAT="powersupersave";

    # Do not suspend USB devices
    # USB_AUTOSUSPEND=0;
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

  networking.hostName = "nixos";

  # make sure eduroam works
  networking.wireless.iwd.enable = true;
  networking.wireless.enable = false;
  networking.networkmanager.wifi.backend = "iwd";
  services.connman.wifi.backend = "iwd"; # maybe can be removed?

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      3000 # localhost React server
      # 57621 # Spotify: to sync local tracks from your filesystem with mobile devices in the same network
    ];
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect
    ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect
    ];
  };

  # mullvad #
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

    # construct a list from the output attrset
    home.packages = with pkgs; [
      lutris
      legendary-gl
    ];
    #++ builtins.attrValues (inputs.nix-gaming.lib.legendaryBuilder
    #  {
    #    inherit (pkgs) system;

    #    games = {
    #      rocket-league = {
    #        # find names with `legendary list`
    #        desktopName = "Rocket League";

    #        # find out on lutris/winedb/protondb
    #        tricks = ["dxvk" "win10"];

    #        # google "<game name> logo"
    #        icon = builtins.fetchurl {
    #          # original url = "https://www.pngkey.com/png/full/16-160666_rocket-league-png.png";
    #          url = "https://user-images.githubusercontent.com/36706276/203341314-eaaa0659-9b79-4f40-8b4a-9bc1f2b17e45.png";
    #          name = "rocket-league.png";
    #          sha256 = "0a9ayr3vwsmljy7dpf8wgichsbj4i4wrmd8awv2hffab82fz4ykb";
    #        };

    #        # if you don't want winediscordipcbridge running for this game
    #        discordIntegration = false;
    #        # if you dont' want to launch the game using gamemode
    #        gamemodeIntegration = false;

    #        preCommands = ''
    #          echo "the game will start!"
    #        '';

    #        postCommands = ''
    #          echo "the game has stopped!"
    #        '';
    #      };
    #    };

    #    opts = {
    #      # same options as above can be provided here, and will be applied to all games
    #      # NOTE: game-specific options take precedence
    #      wine = inputs.nix-gaming.packages.${pkgs.system}.wine-tkg;
    #    };
    #  });

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
    ];

    home.file.".bash_aliases".source = ./. + "${dotfiles}/.bash_aliases";
    home.file.".bashrc".source = ./. + "${dotfiles}/.bashrc";
    home.file.".tmux.conf".source = ./. + "${dotfiles}/.tmux.conf";
    home.file.".alacritty.yml".source = ./. + "${dotfiles}/.alacritty.yml";
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

    # TODO: include in virtualization module
    virt-manager

    yakuake
    # kamoso (using nix-env atm) 
    killall
    google-chrome
    lm_sensors
    (import /home/meeri/.system-config/framework-laptop/fw-ectool/default.nix)
    galaxy-buds-client

    intel-gpu-tools  # for verifying HW acceleration with intel_gpu_top
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
      # package from nixpkgs is outdated: it prompts for an update and is otherwise unusable
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
