{
  config,
  pkgs,
  lib,
  ...
}: {
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  imports = [
    ./programs/neovim/neovim.nix
  ];

  home.packages = with pkgs; [
    tree-sitter
  ];

  xdg.configFile = {
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      manz = "compgen -c | sort -u | fzf | xargs man";
      lg = "lazygit";
    };
    initExtra = ''
      export EDITOR=neovim
      mkcd() { mkdir -p "$1" && cd "$1"; }
      export PATH="$HOME/dev/nix/scripts:$PATH"
    '';
  };

  home.activation.cleanupBackups = lib.hm.dag.entryAfter ["writeBoundary"] ''
    find $HOME/.config -name '*.backup' -type f -delete
  '';
}
