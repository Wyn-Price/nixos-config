{ config, pkgs, ...}:
{
  # discord = (super.discord.overrideAttrs (
  #   oldAttrs: rec {
  #     version = "0.0.21";

  #     src = super.fetchurl {
  #       url = "https://dl.discordapp.net/apps/linux/${version}/discord-${version}.tar.gz";
  #       sha256 = "KDKUssPRrs/D10s5GhJ23hctatQmyqd27xS9nU7iNaM=";
  #     };
  #   }
  # )).override { nss = self.nss_latest; };
  home.packages = with pkgs; [ discord ];
}
