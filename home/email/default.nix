{ config, pkgs, ... }:
{
  accounts.email.accounts = {
    wyn = {
      realName = "Wyn Price";
      address = "me@wynpice.com";
      userName = "me@wynprice.com";
      primary = true;
      passwordCommand = "gpg --decrypt /etc/nixos/secrets/mail-password";

      gpg = {
        encryptByDefault = true;
        signByDefault = true;
        key = "A4086A465ED23C07";
      };

      imap = {
        host = "imappro.zoho.eu";
        port = 993;
      };

      smtp = {
        host = "smtppro.zoho.eu";
        port = 465;
      };

      thunderbird.enable = true;
    };
  };
  programs.thunderbird = {
    enable = true;
    profiles.wyn = {
      isDefault = true;
      withExternalGnupg = true;
    };
  };
}