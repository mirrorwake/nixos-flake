{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    signal-desktop
    discord
  ];
}
