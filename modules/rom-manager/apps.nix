{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    inputs.self.packages.${pkgs.system}.tochd
  ];
}
