{ osConfig, ... }:
{
  imports = [
    ./git.nix
    ./helix.nix
    ./xdg.nix
  ];

  home = { inherit (osConfig.system) stateVersion; };

  programs = {
    command-not-found.enable = false;
    fish.enable = true;
  };
}
