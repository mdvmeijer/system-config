{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (gnuradio3_8.override {
      extraPackages = with gnuradio3_8Packages; [
        osmosdr
        limesdr
      ];
    })
    limesuiteWithGui
    gqrx
    rtl-sdr-osmocom
  ];

  hardware.rtl-sdr.enable = true;

  # Without udev rules, gnuradio cannot access the rtl-sdr dongle.
  # See https://github.com/jopohl/urh/wiki/SDR-udev-rules
  services.udev.extraRules = ''
    # limesuite rules
    # See https://github.com/myriadrf/LimeSuite/blob/master/udev-rules/64-limesuite.rules
    SUBSYSTEM=="usb", ATTR{idVendor}=="04b4", ATTR{idProduct}=="8613", SYMLINK+="stream-%k", MODE="666"
    SUBSYSTEM=="usb", ATTR{idVendor}=="04b4", ATTR{idProduct}=="00f1", SYMLINK+="stream-%k", MODE="666"
    SUBSYSTEM=="usb", ATTR{idVendor}=="0403", ATTR{idProduct}=="601f", SYMLINK+="stream-%k", MODE="666"
    SUBSYSTEM=="usb", ATTR{idVendor}=="1d50", ATTR{idProduct}=="6108", SYMLINK+="stream-%k", MODE="666"
    SUBSYSTEM=="xillybus", MODE="666"
    SUBSYSTEM=="tty", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6001", MODE="0666"
  '';
}
