{
  description = "Automatic system configuration for Framework laptop";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fw-ectool.url = "github:ssddq/fw-ectool";
    hyprland.url = "github:hyprwm/Hyprland";
    # nix-gaming.url = "github:fufexan/nix-gaming";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, fw-ectool, hyprland }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;

      overlay-fw-ectool = final: prev: {
        fw-ectool = fw-ectool.packages.${prev.system}.default;
      };
    in {
      nixosConfigurations = {
        lateralus = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-fw-ectool ]; }) 
            ./hosts/lateralus/default.nix
            ./modules/base-setup.nix
            ./modules/virtualization.nix
            ./modules/hyprland.nix
            hyprland.nixosModules.default
            {programs.hyprland.enable = true;}

            ./modules/work-user.nix

            ./modules/gaming/emulation.nix
            ./modules/gaming/default.nix

            ./modules/temp/embedded-AI.nix
            ./modules/temp/abo-stuff.nix

            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              #home-manager.users.meeri = {
              #  imports = [ ./home.nix ];
              #}
            }
          ];
        };
      }; 
    };
}
