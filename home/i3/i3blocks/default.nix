inputs@{ pkgs, ... }:
let
  text = with builtins; concatStringsSep "\n" (map (p: import p inputs) [
    ./cpu.nix
    ./time.nix
  ]);
in pkgs.writeTextFile {
  name = "i3blocks.conf";
  text = text;
}
