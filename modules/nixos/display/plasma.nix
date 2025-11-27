{
  config,
  lib,
  pkgs,
  project,
  system,
  ...
}:
{
  config = lib.mkIf (config.mama.desktop == "plasma") {
    services = {
      displayManager.sddm = {
        enable = true;
        theme = "${project.packages.reactionary-plus.result.${system}}/share/sddm/themes/reactionary";
      };
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

      systemPackages = [
        project.packages.reactionary-plus.result.${system}
        project.packages.split-clock.result.${system}
      ];
    };
  };
}
