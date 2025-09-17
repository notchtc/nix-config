{ osConfig, ... }:
{
  imports = [
    ../shared
    ./environment
    ./display
    ./nix.nix
    ./profiles.nix
    ./programs
    ./services
  ];

  home.stateVersion = osConfig.system.stateVersion;
}
