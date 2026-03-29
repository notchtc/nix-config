{ osConfig, ... }:
{
  imports = [
    ./environment
    ./nix.nix
    ./programs
  ];

  home.stateVersion = osConfig.system.stateVersion;
}
