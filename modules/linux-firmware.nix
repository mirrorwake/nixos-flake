{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    linux-firmware
  ];

  hardware.enableAllFirmware = true;
}
