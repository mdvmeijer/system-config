{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (gnuradio.override {
      extraPackages = with gnuradioPackages; [
        osmosdr
      ];
    })
  ];

  # Without udev rules, gnuradio cannot access the rtl-sdr dongle.
  # See https://github.com/jopohl/urh/wiki/SDR-udev-rules
  services.udev.extraRules = ''
    # original RTL2832U vid/pid (hama nano, for example)
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0bda", ATTRS{idProduct}=="2832", MODE:="0666"
  '';
}
