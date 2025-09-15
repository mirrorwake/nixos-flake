{
  config,
  pkgs,
  ...
}: {
  home.username = "mirror";
  home.homeDirectory = "/home/mirror";

  imports = [
    ../../home/common.nix
    # archetypes
    ../../home/archetypes/desktop.nix
    ../../home/archetypes/laptop.nix
    # additional packages
    ../../home/programs/gimp.nix
    ../../home/programs/libreoffice.nix
    ../../home/programs/calibre.nix
    ../../home/messengers.nix
    ../../home/ripping.nix
    # games
    ../../home/games/prismlauncher.nix
    ../../home/games/steam.nix
    ../../home/games/proton.nix
  ];

  enableLibreOffice = true;
}
