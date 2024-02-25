{ config, pkgs, ... }:

{
  # https://discourse.nixos.org/t/advice-needed-installing-doom-emacs/8806/5
  home.file.".doom.d" = {
    source = ./doom.d;
    # recursive = true;
    onChange = builtins.readFile ./doom-sync.sh;
  };

  home.packages = with pkgs; [
    pandoc  # Use because default .md backend wrongly formats code blocks
    texlive.combined.scheme-full  # For LaTeX + PDF export
  ];
}
