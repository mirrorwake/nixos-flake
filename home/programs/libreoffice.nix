{
  config,
  pkgs,
  lib,
  ...
}: {
  options.enableLibreOffice = lib.mkEnableOption "LibreOffice";

  config = lib.mkIf config.enableLibreOffice {
    home.packages = with pkgs; [
      libreoffice-fresh
    ];
  };
}
