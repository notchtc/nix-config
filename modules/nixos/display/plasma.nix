{
  config,
  lib,
  packages,
  pkgs,
  system,
  ...
}:
{
  config = lib.mkIf config.mama.profiles.graphical.enable {
    services = {
      displayManager.sddm.enable = true;
      desktopManager.plasma6.enable = true;
    };

    programs.ssh = {
      enableAskPassword = true;
      askPassword = "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";
    };

    environment = {
      variables.KWIN_USE_OVERLAYS = 1;

      plasma6.excludePackages = lib.attrValues {
        inherit (pkgs.kdePackages)
          baloo-widgets
          elisa
          kate
          konsole
          ktexteditor
          kwin-x11
          plasma-browser-integration
          plasma-workspace-wallpapers
          ;
      };

      systemPackages = [ packages.split-clock.result.${system} ];
    };
  };
}
