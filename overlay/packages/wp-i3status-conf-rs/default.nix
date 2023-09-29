{ pkgs, rustPlatform, fetchFromGitHub }:

rustPlatform.buildRustPackage rec {
  pname = "wp-i3status-conf-rs";
  version = "v0.0.5";

  src = fetchFromGitHub {
    owner = "Wyn-Price";
    repo = "i3status-conf-rs";
    rev = version;
    hash = "sha256-z6XIERFVu6o0+sFWLFS+6LCNj/ymv7GadOgtaIeHrXg=";
  };

  nativeBuildInputs = with pkgs; [
    pkg-config
  ];

  buildInputs = with pkgs; [
    openssl
  ];

  cargoSha256 = "sha256-WpMik1kK1Ckh+EUIRdoWa8As2jbyL+jo8d4gLg069os=";

}