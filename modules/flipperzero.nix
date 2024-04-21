{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    qFlipper
  ];
  
  # Without udev rules, qFlipper does not recognize Flipper Zero.
  # See https://forum.flipper.net/t/qflipper-serial-port-unable-to-be-accessed/4324
  services.udev.extraRules = ''
    # Flipper Zero serial port
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="5740", ATTRS{manufacturer}=="Flipper Devices Inc.", TAG+="uaccess", GROUP="dialout"
    # Flipper Zero DFU
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", ATTRS{manufacturer}=="STMicroelectronics", TAG+="uaccess", GROUP="dialout"

  '';
}
