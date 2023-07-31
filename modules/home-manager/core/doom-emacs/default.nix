{ pkgs, config, inputs, ... }:

{
  home-manager.users.meeri = { pkgs, ... }: {
    imports =
      [
        inputs.nix-doom-emacs.hmModule
      ];

    # services.emacs.enable = true;

    programs.doom-emacs = {
      enable = true;
      doomPrivateDir = ./doom.d;
      # emacsPackage = pkgs.emacs-gtk;
    };
  };
}
