{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) attrValues mkIf;
  inherit (pkgs) kdePackages;
  inherit (config.mama) desktop;
in
{
  config = mkIf (desktop == "plasma") {
    services = {
      displayManager.sddm.enable = true;
      desktopManager.plasma6.enable = true;
    };

    programs.ssh = {
      enableAskPassword = true;
      askPassword = "${kdePackages.ksshaskpass}/bin/ksshaskpass";
    };

    environment = {
      variables.KWIN_USE_OVERLAYS = 1;
      plasma6.excludePackages = attrValues {
        inherit (kdePackages)
          elisa
          kate
          konsole
          ktexteditor
          kwin-x11
          plasma-browser-integration
          plasma-workspace-wallpapers
          ;
      };
    };
  };
}
