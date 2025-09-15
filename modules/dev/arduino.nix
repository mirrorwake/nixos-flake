# modules/dev/arduino.nix
{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    platformio
    arduino-cli
  ];
}
