{
  config,
  lib,
  pkgs,
  project,
  system,
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
      displayManager.sddm = {
        enable = true;
        theme = "${project.packages.reactionary-plus.result.${system}}/share/sddm/themes/reactionary";
      };
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
          baloo-widgets
          elisa
          kate
          konsole
          ktexteditor
          kwin-x11
          plasma-workspace-wallpapers
          ;
      };

      systemPackages = [
        project.packages.reactionary-plus.result.${system}
        project.packages.split-clock.result.${system}
      ];
    };
  };
}
