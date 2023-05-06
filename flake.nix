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
        # Get from unstable channel for additional module options
        catppuccin-gtk = nixpkgs-unstable.legacyPackages.${prev.system}.catppuccin-gtk;
      };
    in {
      nixosConfigurations = {
        lateralus = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-fw-ectool overlay-catppuccin ]; }) 
            ./hosts/lateralus/default.nix
            ./modules/base-setup.nix
            ./modules/virtualization.nix
            ./modules/hyprland.nix
            ./modules/qutebrowser.nix

            ./modules/themes/catppuccin/macchiato-rosewater.nix

            ./modules/work-user.nix

            ./modules/gaming/emulation.nix
            ./modules/gaming/default.nix

            ./modules/temp/embedded-AI.nix
            ./modules/temp/abo-stuff.nix
            ./modules/obs.nix

            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            }
          ];
        };
      }; 
    };
}
