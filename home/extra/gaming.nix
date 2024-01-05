{ config, pkgs, username, ... }:

{
  home-manager.users.${username} = { pkgs, ... }: {
    home.packages = with pkgs; [
      # lutris
      # legendary-gl
      dwarf-fortress
      superTux
      superTuxKart
    ];
  };
}
