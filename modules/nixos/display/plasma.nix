{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.mama.desktops.plasma.enable {
    services = {
      displayManager.sddm.enable = true;
      desktopManager.plasma6.enable = true;
    };

    programs.ssh = {
      enableAskPassword = true;
      askPassword = "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";
    };

    environment.plasma6.excludePackages = lib.attrValues {
      inherit (pkgs.kdePackages)
        elisa
        kate
        konsole
        ktexteditor
        kwin-x11
        plasma-workspace-wallpapers
        ;
    };
  };
}
