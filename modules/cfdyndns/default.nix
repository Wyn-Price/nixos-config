{ config, pkgs, ... }:
{  
  services.cfdyndns = {
    enable = true;
    email = "wynprice999@gmail.com";
    records = "home.wynprice.com";
    # TODO: Don't hardcode?
    apikeyFile = "/var/lib/wp/cfdyndns-api.key";
  }
}