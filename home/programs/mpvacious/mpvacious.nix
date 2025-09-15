{
  pkgs,
  lib,
  ...
}:
pkgs.stdenv.mkDerivation {
  pname = "mpvacious";
  version = "1.0";

  src = pkgs.fetchFromGitHub {
    owner = "Ajatt-Tools";
    repo = "mpvacious";
    rev = "master";
    sha256 = "sha256-dxZbZVJaSUyzOn28YCpXmD7Vgfgf1Ye1yuhYoPAGKYU="; # replace with real hash
  };

  dontBuild = true;
  dontConfigure = true;

  installPhase = ''
    mkdir -p $out/share/mpv/scripts
    cp -r . $out/share/mpv/scripts/
  '';
}
