{ project, osConfig, ... }:
{
  imports = [
    project.inputs.chaotic.result.homeManagerModules.default
    ./git.nix
    ./helix.nix
    ./xdg.nix
  ];

  home = {
    stateVersion = osConfig.system.stateVersion;
  };

  programs = {
    command-not-found.enable = false;
    fish.enable = true;
    gpg.enable = true;
  };
}
