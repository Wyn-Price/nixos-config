{ lib, stdenv, makeWrapper, fetchurl, openjdk17 }:

stdenv.mkDerivation rec {
  pname = "minecraftforge-installer-1.19.2";
  version = "1.19.2-43.2.12";

  src = fetchurl {
    url = "https://maven.minecraftforge.net/net/minecraftforge/forge/${version}/forge-${version}-installer.jar";
    sha256 = "";
  };

  nativeBuildInputs = [ makeWrapper ];

  buildCommand = ''
    ls $out
    jar=$out/share/java/forge-${version}-installer.jar
    install -Dm444 $src $jar
    makeWrapper ${openjdk17}/bin/java -jar $jar
  '';
}