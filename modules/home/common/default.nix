{ inputs, ... }:
{
  imports = [
    inputs.chaotic.homeManagerModules.default
    inputs.nix-index-database.hmModules.nix-index
    ./git.nix
    ./helix.nix
    ./xdg.nix
  ];

  home = {
    stateVersion = "24.05";
  };

  programs = {
    command-not-found.enable = false;
    nix-index.enable = true;
    nix-index-database.comma.enable = true;
    gpg.enable = true;
    zsh.enable = true;
  };
}
