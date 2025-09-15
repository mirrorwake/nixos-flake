# modules/embedded-devices.nix
{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    binwalk
    qemu
    ghidra-bin
    xxd
    netcat
    binutils
    mtdutils
    squashfsTools
    ubi_reader
  ];
}
