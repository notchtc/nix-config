{ inputs, ... }:
{
  imports = [ inputs.nix-index-database.result.homeModules.nix-index ];
  programs = {
    command-not-found.enable = false;
    nix-index-database.comma.enable = true;
    nix-index.enable = true;
  };
}
