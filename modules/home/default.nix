{ osConfig, ... }:
{
  imports = [
    ./environment
    ./display
    ./nix.nix
    ./programs
    ./services
  ];

  home.stateVersion = osConfig.system.stateVersion;
}
