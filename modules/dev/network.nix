# modules/embedded-devices.nix
{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    nmap
    tcpdump
  ];
}
