{ osConfig, ... }:
{
  imports = [
    ./environment
    ./nix.nix
    ./programs
    ./services
  ];

  home.stateVersion = osConfig.system.stateVersion;
}
