{
  description = "Automatic system configuration for Framework laptop";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fw-ectool.url = "github:ssddq/fw-ectool";
    # nix-gaming.url = "github:fufexan/nix-gaming";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, fw-ectool }:
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

            ./modules/work-user.nix

            ./modules/gaming/emulation.nix
            ./modules/temp/embedded-AI.nix

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
