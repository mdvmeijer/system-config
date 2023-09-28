{ pkgs, config, inputs, ... }:

{
  home-manager.users.meeri = { pkgs, ... }: {
    # imports =
      # [
        # inputs.nix-doom-emacs.hmModule
      # ];

    # services.emacs.enable = true;

    # programs.doom-emacs = {
    #   enable = true;
    #   doomPrivateDir = ./doom.d;
    #   # emacsPackage = pkgs.emacs-gtk;
    # };

    # https://discourse.nixos.org/t/advice-needed-installing-doom-emacs/8806/5
    home.file.".doom.d" = {
      source = ./doom.d;
      # recursive = true;
      onChange = builtins.readFile ./doom-sync.sh;
    };
  };
}
