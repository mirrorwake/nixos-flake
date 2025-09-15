{
  config,
  pkgs,
  ...
}: {
  imports = [
  ];

  home.packages = with pkgs; [
    brightnessctl
  ];

  xdg.configFile = {
  };
}
