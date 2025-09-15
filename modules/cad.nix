# modules/cad.nix
{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    freecad
    orca-slicer
    moonraker
    mainsail
  ];

  services.moonraker = {
    enable = true;
    user = "mirror";
  };

  networking.firewall.allowedTCPPorts = [7125]; # Mainsail default port ];
}
