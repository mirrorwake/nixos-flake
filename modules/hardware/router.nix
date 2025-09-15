{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (config._module.args) lanInterface wanInterface;
in {
  options = {
    _module.args.lanInterface = lib.mkOption {
      type = lib.types.str;
      description = "The interface to use for LAN.";
    };

    _module.args.wanInterface = lib.mkOption {
      type = lib.types.str;
      description = "The interface to use for WAN.";
    };
  };

  config = {
    boot.kernel.sysctl."net.ipv4.ip_forward" = "1";

    networking.nat = {
      enable = true;
      externalInterface = wanInterface;
      internalInterfaces = [lanInterface];
    };

    networking.interfaces.${lanInterface}.useDHCP = lib.mkDefault false;
    networking.interfaces.${lanInterface}.ipv4.addresses = lib.mkDefault [
      {
        address = "192.168.99.1";
        prefixLength = 24;
      }
    ];

    services.dnsmasq.enable = true;
    services.dnsmasq.settings = {
      interface = lanInterface;
      dhcp-range = "192.168.99.50,192.168.99.150,12h";
    };

    networking.firewall.enable = true;
    networking.firewall.interfaces.${lanInterface}.allowedUDPPorts = [67 68];
    networking.firewall.interfaces.${lanInterface}.allowedTCPPorts = [22];
  };
}
