{ config, pkgs, ... }:

{
  # https://discourse.nixos.org/t/advice-needed-installing-doom-emacs/8806/5
  home.file.".doom.d" = {
    source = ./doom.d;
    # recursive = true;
    onChange = builtins.readFile ./doom-sync.sh;
  };
}
