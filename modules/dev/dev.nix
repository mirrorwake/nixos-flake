# roles/archetypes/dev.nix
{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./arduino.nix
    ./embedded-devices.nix
    ./python.nix
    ./network.nix
  ];

  environment.systemPackages = with pkgs; [
    picocom
    minicom
    screen
    lua
    love
    csvkit
    ffmpeg
    jq
    alejandra
    flashrom
    zlib
    pkg-config
    sigrok-cli
    pulseview
  ];
}
