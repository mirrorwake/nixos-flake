{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    neovim
    gcc # Needed for Treesitter compilation
    git
    curl
    fd
    ripgrep
    fzf
    lazygit
    nerd-fonts.jetbrains-mono
    wl-clipboard
  ];
}
