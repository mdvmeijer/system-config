{
  description = "Automatic system configuration for Framework laptop";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fw-ectool.url = "github:ssddq/fw-ectool";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, fw-ectool, hyprland }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };

      lib = nixpkgs.lib;

      overlay-fw-ectool = final: prev: {
        fw-ectool = fw-ectool.packages.${prev.system}.default;
      };
      overlay-catppuccin = final: prev: {
        # Get from unstable for additional module options
        catppuccin-gtk = nixpkgs-unstable.legacyPackages.${prev.system}.catppuccin-gtk;
      };
      overlay-hyprpicker = final: prev: {
        # Get from unstable because package not in nixpkgs 22.11
        hyprpicker = nixpkgs-unstable.legacyPackages.${prev.system}.hyprpicker;
      };
      overlay-waybar = final: prev: {
        # Enable experimental options such that wlr/overlays works
        waybar = prev.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
        });
      };

      username-main = "meeri";
      username-work = "max";
    in {
      nixosConfigurations = {
        lateralus = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; inherit username-main; inherit username-work; };
          modules = [
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-fw-ectool overlay-catppuccin overlay-hyprpicker overlay-waybar]; }) 

            # Host-specific config
            ./hosts/lateralus/default.nix

            # System-level config
            ./modules/system/core/default.nix

            ./modules/system/extra/gaming/default.nix
            ./modules/system/extra/gaming/emulation.nix
            ./modules/system/extra/temp/embedded-AI.nix
            ./modules/system/extra/temp/abo-stuff.nix

            # Home-manager config
            ./modules/home-manager/main-user.nix
            ./modules/home-manager/work-user.nix

            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            }
          ];
        };
      }; 
    };
}
