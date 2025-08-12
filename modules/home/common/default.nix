{ osConfig, ... }:
{
  imports = [
    ./helix.nix
    ./vcs.nix
    ./xdg.nix
  ];

  home = { inherit (osConfig.system) stateVersion; };

  programs = {
    command-not-found.enable = false;
    zsh.enable = true;
  };
}
