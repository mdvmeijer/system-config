{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vscode.fhs
  ];
}
