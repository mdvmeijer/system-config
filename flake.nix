{
  description = "Automatic system configuration for Framework laptop";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fw-ectool.url = "github:ssddq/fw-ectool";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, fw-ectool, hyprland }:
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
        ];
      };

      overlay-fw-ectool = final: prev: {
        fw-ectool = fw-ectool.packages.${prev.system}.default;
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
            ./hosts/lateralus/default.nix

            ./modules/system/core/default.nix
            ./modules/system/extra/gaming/default.nix

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

            ./modules/system/core/default.nix

            ./modules/home-manager/main-user.nix

            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            }
          ];
        };
      }; 
    };
}
