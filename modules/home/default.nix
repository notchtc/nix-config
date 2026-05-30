{ osConfig, ... }:
{
  imports = [
    ./environment
    ./modules.nix
    ./nix.nix
    ./programs
  ];

  home.stateVersion = osConfig.system.stateVersion;
}
