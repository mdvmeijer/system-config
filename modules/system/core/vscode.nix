{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    unstable.vscode.fhs
    xdg-user-dirs
  ];
}
