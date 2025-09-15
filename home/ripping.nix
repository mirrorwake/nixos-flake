{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    cdparanoia
    flac
    puddletag
  ];
}
