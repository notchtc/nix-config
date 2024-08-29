{ lib, pkgs, ... }:
{
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

  environment.plasma6.excludePackages = lib.attrValues {
    inherit (pkgs.kdePackages)
      elisa
      kate
      konsole
      krdp
      ;
  };
}
