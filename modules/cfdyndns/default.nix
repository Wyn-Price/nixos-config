# Shamelessly copied from https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/misc/cfdyndns.nix
# as they don't provide a way to use API TOKENS
# TODO: PR this upstream
# TODO: this also isn't really a module
{ config, pkgs, lib, ... }:
{
  systemd.services.cfdyndns = {
    description = "CloudFlare Dynamic DNS Client";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    startAt = "*:0/5";
    serviceConfig = {
      Type = "simple";
      User = config.ids.uids.cfdyndns;
      Group = config.ids.gids.cfdyndns;
    };
    environment = {
      CLOUDFLARE_EMAIL="wynprice999@gmail.com";
      CLOUDFLARE_RECORDS="home.wynprice.com";
    };
    script = ''
      export CLOUDFLARE_APITOKEN="$(cat /var/lib/wp/cfdyndns-api.key)"
      ${pkgs.cfdyndns}/bin/cfdyndns
    '';
  };

  users.users = {
    cfdyndns = {
      group = "cfdyndns";
      uid = config.ids.uids.cfdyndns;
    };
  };

  users.groups = {
    cfdyndns = {
      gid = config.ids.gids.cfdyndns;
    };
  };
}