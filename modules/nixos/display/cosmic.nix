{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.mama.desktops.cosmic.enable {
    services = {
      displayManager.cosmic-greeter.enable = true;
      desktopManager.cosmic.enable = true;
    };

    environment.cosmic.excludePackages = lib.attrValues {
      inherit (pkgs) cosmic-edit cosmic-player cosmic-term;
    };
  };
}
