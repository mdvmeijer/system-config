{ config, pkgs, ... }:

let
  mainUser="meeri";
in
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  home-manager.users.${mainUser} = { pkgs, ... }: {
    home.packages = with pkgs; [
      lutris
      legendary-gl
    ];
  };

  nix = {
    # cachix for nixos-gaming
    settings = {
      substituters = [ "https://nix-gaming.cachix.org" ];
      trusted-public-keys = [ "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];
    };
  };
}
