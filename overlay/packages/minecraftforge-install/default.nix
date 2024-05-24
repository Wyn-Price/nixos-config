{ lib, stdenv, makeWrapper, fetchurl, jre, forge }:

stdenv.mkDerivation rec {
  pname = "minecraftforge-installer-${forge.mc-version}";
  version = "${forge.mc-version}-${forge.forge-version}";

  jarname = "forge-${version}-installer.jar";

  src = fetchurl {
    url = "https://maven.minecraftforge.net/net/minecraftforge/forge/${version}/forge-${version}-installer.jar";
    sha256 = forge.installer-sha256;
  };

  nativeBuildInputs = [ makeWrapper ];

  buildCommand = ''
    ${pkg.coreutils}/bin/mkdir -p $out/bin
    ${pkg.coreutils}/bin/install -Dm444 $src $out/share/java/$jarname
    makeWrapper ${jre}/bin/java $out/bin/$pname \
      --add-flags "-jar $out/share/java/$jarname --installServer"
  '';
}