# shell.nix
{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  # enables flakes
  NIX_CONFIG = "experimental-features = nix-command flakes";

  nativeBuildInputs = with pkgs; [
    # nix
    nix
    home-manager
    alejandra

    # git
    git
    git-crypt
    gnupg

    ripgrep
    neovim
    tree
    nmap
    jq
  ];
}
