{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs;
    let 
      myPythonPackages = pythonPackages: with pythonPackages; [
        watchdog
      ];
    in [
      (python3.withPackages myPythonPackages)
      python3.pkgs.pip
    ];
}
