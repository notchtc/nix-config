{ inputs, ... }:
{
  imports = [ inputs.nix-index-database.result.homeModules.default ];
  programs = {
    nix-index-database.comma.enable = true;
    nix-index.enable = true;
  };
}
