{ config, pkgs, libs, ... }:
{
  programs.firefox = {
    enable = true;
    profiles.wp = {
      name = "Wyn Price";
      search.default = "Google";

      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        onepassword-password-manager
      ];

      bookmarks = [
        {
          name = "Search";
          bookmarks = [
            {
              name = "Home Manager";
              keyword = ":hm";
              url = "https://mipmip.github.io/home-manager-option-search/?%s";
            }
          ];
        }
      ];
    };
  };
}