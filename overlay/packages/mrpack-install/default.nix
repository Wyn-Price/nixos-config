{ lib, stdenv, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "mrpack-install";
  version = "v0.16.7";

  # Seems like tests are broken:
  # > running tests
  # > --- FAIL: TestFetchMetadata (0.00s)
  # >     meta_test.go:10: Get "https://maven.quiltmc.org/repository/release/org/quiltmc/quilt-installer/maven-metadata.xml": dial tcp: lookup maven.quiltmc.org on [::1]:53: read udp [::1]:41048->[::1]:53: read: connection refuse
  doCheck = false;

  src = fetchFromGitHub {
    owner = "nothub";
    repo = pname;
    rev = version;
    hash = "sha256-aGIfCd5k8zCKwi/U2Ry4d+9ff4zmFTfl8W0n0m0IJwQ=";
  };

  vendorHash = "sha256-tQbc8fIkSgC9G1m4tMzk7MrOGOwXhNH+GTVXDZR//54=";
}