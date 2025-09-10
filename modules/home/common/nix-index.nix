{ inputs, ... }:
{
  imports = [ inputs.nix-index-database.result.homeModules.nix-index ];
  programs = {
    nix-index-database.comma.enable = true;
    nix-index.enable = true;
  };
}
