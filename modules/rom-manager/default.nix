{
  stdenvNoCC,
  makeWrapper,
  lib,
  python3,
  p7zip,
  mame-tools,
  src,
}:
stdenvNoCC.mkDerivation {
  pname = "tochd";
  version = "unstable-2024-03-12";
  inherit src;
  nativeBuildInputs = [makeWrapper];

  installPhase = ''
    install -Dm755 $src/tochd.py $out/bin/tochd
    patchShebangs $out/bin/tochd
  '';

  postFixup = ''
    wrapProgram $out/bin/tochd \
      --prefix PATH : ${lib.makeBinPath [python3 p7zip mame-tools]}
  '';

  meta = with lib; {
    description = "Convert ISO/CUE/GDI to CHD via chdman";
    license = licenses.mit;
    homepage = "https://github.com/thingsiplay/tochd";
    platforms = platforms.linux;
  };
}
