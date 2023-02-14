pkgs: super:
{
  custom-scripts = {
    wp-screenshot = import ./wp-screenshot.nix { pkgs = pkgs; };
  };
}
