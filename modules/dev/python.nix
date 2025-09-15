# modules/dev/python/python.nix
{
  config,
  pkgs,
  lib,
  ...
}: let
  pyPkgs = pkgs.python3Packages;

  myPython = pkgs.python312.withPackages (ps:
    with ps; [
      pip
      # thermal printer stuff
      python-escpos
      appdirs
      argcomplete
      future
      pillow
      pyserial
      python-barcode
      pyusb
      pyyaml
      qrcode
      setuptools
      six
    ]);
in {
  environment.systemPackages = [myPython];
}
