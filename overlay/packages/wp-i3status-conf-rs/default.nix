{ pkgs, rustPlatform, fetchFromGitHub }:

rustPlatform.buildRustPackage rec {
  pname = "wp-i3status-conf-rs";
  version = "v0.0.2";

  src = fetchFromGitHub {
    owner = "Wyn-Price";
    repo = "i3status-conf-rs";
    rev = version;
    hash = "sha256-QsvFXm8E7S8/n8J3dcHQ3ov01pGKZeMtnEWVwea2gC0=";
  };

  nativeBuildInputs = with pkgs; [
    pkg-config
  ];

  buildInputs = with pkgs; [
    openssl
  ];

  cargoSha256 = "sha256-rSJZvMS7QfOxksVr3FXWQGOm3VrxLyvD+xjxCIcYBI0=";

}