{ lib, stdenv, makeWrapper, fetchurl, jre }:

stdenv.mkDerivation rec {
  pname = "minecraftforge-installer-1.19.2";
  version = "1.19.2-43.2.12";

  jarname = "forge-${version}-installer.jar";

  src = fetchurl {
    url = "https://maven.minecraftforge.net/net/minecraftforge/forge/${version}/forge-${version}-installer.jar";
    sha256 = "XKKGV0LmuumI0YZCK5dFoiDm2Vz6I5cDkvVlCBSjrEg=";
  };

  nativeBuildInputs = [ makeWrapper ];

  buildCommand = ''
    mkdir -p $out/bin
    install -Dm444 $src $out/share/java/$jarname
    makeWrapper ${jre}/bin/java $out/bin/$pname \
      --add-flags "-jar $out/share/java/$jarname --installServer"
  '';
}