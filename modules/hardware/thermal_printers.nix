# modules/hardware/thermal_printers.nix
{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    netcat
    imagemagick
    cups
    ghostscript
  ];
}
