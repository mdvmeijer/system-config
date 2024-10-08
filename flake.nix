{
  description = "NixOS configs for my systems";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fw-ectool.url = "github:ssddq/fw-ectool";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, fw-ectool, nixos-hardware }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          permittedInsecurePackages = [
              "electron-25.9.0"
          ];
        };
        overlays = [ 
          overlay-fw-ectool
        ];
      };

      overlay-fw-ectool = final: prev: {
        fw-ectool = fw-ectool.packages.${prev.system}.default;
      };
    in {
      nixosConfigurations = {
        lateralus = nixpkgs.lib.nixosSystem {
          inherit system;
          inherit pkgs;
          modules = [
            ./hosts/lateralus

            ./modules/core

            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.meeri = {
                home.stateVersion = "22.11";
                imports = [
                  ./home/core
                ];
              };
            }
          ];
        };
        ayame = nixpkgs.lib.nixosSystem {
          inherit system;
          inherit pkgs;
          modules = [
            ./hosts/ayame
            nixos-hardware.nixosModules.lenovo-thinkpad-t14s

            ./modules/core
            ./modules/hyprland
            ./modules/gaming
            ./modules/gnuradio.nix

            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.meeri = {
                home.stateVersion = "23.05";
                imports = [
                  ./home/core
                  ./home/hyprland
                  ./home/work.nix
                ];
              };
            }
          ];
        };
        zenith = nixpkgs.lib.nixosSystem {
          inherit system;
          inherit pkgs;
          modules = [
            ./hosts/zenith
            nixos-hardware.nixosModules.framework-13-7040-amd

            ./modules/core
            ./modules/hyprland
            ./modules/gaming
            ./modules/ledgerlive.nix
            ./modules/flipperzero.nix
            ./modules/gnuradio.nix

            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "bak";

              home-manager.users.meeri = {
                home.stateVersion = "23.11";
                imports = [
                  ./home/core
                  ./home/hyprland
                  ./home/gaming.nix
                  ./home/work.nix
                ];
              };
            }
          ];
        };
      }; 
    };
}
