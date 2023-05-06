{ pkgs, config, ... }:

{
  home-manager.users.meeri = {
    home.stateVersion = "22.11";

    programs.git = {
      enable = true;

      userName = "M.D.V. Meijer";
      userEmail = "mdvmeijer@protonmail.com";

      aliases = {
        ci = "commit";
        co = "checkout";
        s = "status";
      };
    };
  };
}
