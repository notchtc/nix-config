{ inputs, ... }:
{
  imports = [
    inputs.chaotic.homeManagerModules.default
    ./git.nix
    ./helix.nix
    ./xdg.nix
  ];

  home = {
    stateVersion = "24.05";
  };

  programs = {
    command-not-found.enable = false;
    fish.enable = true;
    gpg.enable = true;
  };
}
