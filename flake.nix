{
  description = "Automatic system configuration for Framework laptop";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fw-ectool.url = "github:ssddq/fw-ectool";
    hyprland.url = "github:hyprwm/Hyprland/v0.32.0";

    # nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
    # emacs-overlay.url = "github:nix-community/emacs-overlay";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, fw-ectool, hyprland, emacs-overlay }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          permittedInsecurePackages = [
              "electron-24.8.6"
          ];
        };
        overlays = [ 
          overlay-fw-ectool
          overlay-hyprpicker
          overlay-waybar
          # overlay-android-studio
          overlay-unstable
          # overlay-swayosd
        ];
      };

      # nixpkgs-unstable.config.allowUnfree = true;

      overlay-fw-ectool = final: prev: {
        fw-ectool = fw-ectool.packages.${prev.system}.default;
      };
      overlay-hyprpicker = final: prev: {
        # Get from unstable for latest version
        hyprpicker = nixpkgs-unstable.legacyPackages.${prev.system}.hyprpicker;
      };
      overlay-waybar = final: prev: {
        # Enable experimental options such that wlr/overlays works
        waybar = nixpkgs-unstable.legacyPackages.${prev.system}.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
        });
      };
      overlay-swayosd = final: prev: {
        # Get from unstable for latest version
        swayosd = nixpkgs-unstable.legacyPackages.${prev.system}.swayosd;
      };
      # overlay-android-studio = final: prev: {
      #   # Get from unstable for latest version
      #   android-studio = nixpkgs-unstable.legacyPackages.${prev.system}.android-studio;
      # };
      overlay-unstable = final: prev: {
        unstable = import nixpkgs-unstable {
          system = "x86_64-linux";
          config.allowUnfree = true; # snake eyes!
        };
      };

      username-main = "meeri";
      username-work = "max";
    in {
      nixosConfigurations = {
        lateralus = nixpkgs.lib.nixosSystem {
          inherit system;
          inherit pkgs;
          specialArgs = { inherit inputs; inherit username-main; inherit username-work; };
          modules = [
            # ({ config, pkgs, ... }: { inputs.nixpkgs-unstable.config.allowUnfree = true; })
            # Hardware-specific config
            ./hosts/lateralus/default.nix

            # System-level config
            ./modules/system/core/default.nix
            ./modules/system/extra/gaming/default.nix

            # Home-manager config
            ./modules/home-manager/main-user.nix
            ./modules/home-manager/work-user.nix

            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            }
          ];
        };
        ayame = nixpkgs.lib.nixosSystem {
          inherit system;
          inherit pkgs;
          specialArgs = { inherit inputs; inherit username-main; };
          modules = [
            ./hosts/ayame/configuration.nix

            # System-level config
            ./modules/system/core/default.nix
            # ./modules/system/extra/gaming/default.nix

            # Home-manager config
            ./modules/home-manager/main-user.nix
            # ./modules/home-manager/work-user.nix

            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            }
          ];
        };
      }; 
    };
}
