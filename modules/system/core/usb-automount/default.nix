# Source: https://superuser.com/a/64970

{ pkgs, config, ... }:

let
  # Since udev blocks while directly running a script,
  # this starter script starts the main usb-automount script in the background.
#  usb-automount-starter = pkgs.writeShellScriptBin "usb-automount-starter" (builtins.readFile ./scripts/usb-automount-starter.sh);
  usb-automount-starter = pkgs.writeShellScriptBin "usb-automount-starter" ''
    $1 $2 &
  ''; 

  usb-automount-background-script = pkgs.writeShellScriptBin "usb-automount-background-script" (builtins.readFile ./scripts/usb-automount-background-script.sh);
in
{
  # https://unix.stackexchange.com/questions/186862/how-to-add-scripts-for-udev-to-run
  services.udev.extraRules = ''
    ENV{ID_FS_LABEL_ENC}=="?*", ACTION=="add", SUBSYSTEMS=="usb", RUN+="${usb-automount-starter}/bin/usb-automount-starter ${usb-automount-background-script}/bin/usb-automount-background-script %k"
  '';
 
  # environment.systemPackages = with pkgs; [
  #   usb-automount-starter
  #   usb-automount-background-script
  # ];
}
