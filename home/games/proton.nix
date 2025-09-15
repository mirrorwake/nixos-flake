# home/games/proton.nix
{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    vulkan-tools
    protonup-qt
    protontricks
    proton-caller
  ];
}
