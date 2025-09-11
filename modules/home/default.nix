{ osConfig, ... }:
{
  imports = [
    ../shared
    ./display
    ./nix.nix
    ./profiles.nix
    ./programs
    ./services
  ];
  home.stateVersion = osConfig.system.stateVersion;
  manual = {
    manpages.enable = false;
    html.enable = false;
    json.enable = false;
  };
}
