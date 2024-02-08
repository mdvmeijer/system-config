{ config, pkgs, ... }:

{
  # Default icons file from the lf repo
  xdg.configFile."lf/icons".source = ./res/icons;

  # TODO: Image preview support for alacritty
  # home.packages = [ pkgs.kitty ];

  # Based on https://github.com/vimjoyer/lf-nix-video
  programs.lf = {
    enable = true;

    settings = {
      preview = true;
      # hidden = true;
      drawbox = true;
      icons = true;
      ignorecase = true;
    };

    commands = {
      dragon-out = ''%${pkgs.xdragon}/bin/xdragon -a -x "$fx"'';
      # ripdrag-out = ''%${pkgs.ripdrag}/bin/ripdrag -a -x "$fx"'';
      editor-open = ''$$EDITOR $f'';
    };

    keybindings = {
      "\\\"" = "";
      o = "";
      d = "";

      gh = "cd";
      "g/" = "cd /";

      do = "dragon-out";

      e = "editor-open";
      i = ''''$${pkgs.bat}/bin/bat --paging=always --theme=gruvbox-dark "$f"'';
    };

    extraConfig =
    let
      previewer =
        pkgs.writeShellScriptBin "pv.sh" ''
        file=$1
        w=$2
        h=$3
        x=$4
        y=$5

        if [[ "$( ${pkgs.file}/bin/file -Lb --mime-type "$file")" =~ ^image ]]; then
            ${pkgs.kitty}/bin/kitty +kitten icat --silent --stdin no --transfer-mode file --place "''${w}x''${h}@''${x}x''${y}" "$file" < /dev/null > /dev/tty
            exit 1
        fi

        ${pkgs.pistol}/bin/pistol "$file"
      '';
      cleaner = pkgs.writeShellScriptBin "clean.sh" ''
        ${pkgs.kitty}/bin/kitty +kitten icat --clear --stdin no --silent --transfer-mode file < /dev/null > /dev/tty
      '';
    in
    ''
      set cleaner ${cleaner}/bin/clean.sh
      set previewer ${previewer}/bin/pv.sh
    '';
  };
}
