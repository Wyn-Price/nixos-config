{ config, pkgs, libs, ... }:
{

  programs.firefox = {
    enable = true;
    profiles.wp = {
      name = "Wyn Price";
      search.default = "Google";

      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        onepassword-password-manager
        vimium-c
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
            {
              name = "Nixos Options";
              keyword = ":nix";
              url = "https://search.nixos.org/options?query=%s";
            }
            {
              name = "Nixos Packages";
              keyword = ":packs";
              url = "https://search.nixos.org/packages?query=%s";
            }
          ];
        }
      ];
    };
  };
}
