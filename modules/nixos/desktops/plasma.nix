{ lib, pkgs, ... }:
{
  environment.systemPackages = lib.attrValues { inherit (pkgs.kdePackages) sddm-kcm; };

  services = {
    displayManager = {
      sddm = {
        enable = true;
        wayland = {
          enable = true;
          compositor = "kwin";
        };
      };
      defaultSession = "plasma";
    };

    desktopManager.plasma6.enable = true;
  };

  systemd.services.plymouth-quit.preStart = "${pkgs.kbd}/bin/chvt 7";

  environment.plasma6.excludePackages = lib.attrValues {
    inherit (pkgs.kdePackages) elisa kate konsole;
  };
}
