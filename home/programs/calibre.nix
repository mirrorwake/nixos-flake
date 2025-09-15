# home/programs/calibre/calibre.nix
{
  config,
  pkgs,
  lib,
  ...
}: let
  calibrePluginsDir = "${config.xdg.configHome}/calibre/plugins";

  koboPlugin = pkgs.fetchurl {
    url = "https://github.com/jgoguen/calibre-kobo-driver/releases/download/v3.7.2/KoboTouchExtended.zip";
    sha256 = "00jgi0ib2j8id564mk712m3kzfwrkw59pn96jb00kpjvrzcnbasv";
  };
  drmPlugins = pkgs.fetchurl {
    url = "https://github.com/noDRM/DeDRM_tools/releases/download/v10.0.3/DeDRM_tools_10.0.3.zip";
    sha256 = "0j98lrszmw2px369dlr8a35yql9ds34z878kl76fj9hczc7f6jc6";
  };

  extractedPlugins = pkgs.stdenv.mkDerivation {
    pname = "drm-zips";
    version = "10.0.3";
    src = drmPlugins;
    dontUnpack = true;
    nativeBuildInputs = [pkgs.unzip];
    installPhase = ''
      mkdir -p $out
      unzip $src DeDRM_plugin.zip Obok_plugin.zip
      mv DeDRM_plugin.zip Obok_plugin.zip $out/
    '';
  };
in {
  home.packages = [pkgs.calibre];

  home.activation.installCalibrePlugins = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p "${calibrePluginsDir}"

    cp -vf "${koboPlugin}" "${calibrePluginsDir}/KoboTouchExtended.zip"
    cp -vf "${extractedPlugins}/DeDRM_plugin.zip" "${calibrePluginsDir}/DeDRM_plugin.zip"
    cp -vf "${extractedPlugins}/Obok_plugin.zip" "${calibrePluginsDir}/Obok_plugin.zip"

    calibre-customize -a "${calibrePluginsDir}/KoboTouchExtended.zip" || true
    calibre-customize -a "${calibrePluginsDir}/DeDRM_plugin.zip" || true
    calibre-customize -a "${calibrePluginsDir}/Obok_plugin.zip" || true
  '';
}
