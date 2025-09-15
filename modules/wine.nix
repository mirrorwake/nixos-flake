{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    wine
    wine64
  ];
}
