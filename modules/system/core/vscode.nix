{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vscode.fhs
    xdg-user-dirs
  ];
}
