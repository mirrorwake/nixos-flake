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
    # serial debug
    picocom
    minicom
    screen
    # languages and compilers
    ## lua
    lua
    love
    ## nodejs
    nodejs_24
    csvkit
    # docker
    docker
    docker-compose
    docker-color-output
    ffmpeg
    jq
    alejandra
    flashrom
    zlib
    pkg-config
    sigrok-cli
    pulseview
    vscodium-fhs
    podman
    podman-desktop
  ];
}
