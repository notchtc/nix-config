{
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = lib.attrValues {
    inherit
      (pkgs.kdePackages)
      sddm-kcm
      ;
  };

  services.xserver = {
    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
      };
      defaultSession = "plasmawayland";
    };

    desktopManager.plasma5.enable = true;
  };

  environment.plasma5.excludePackages = lib.attrValues {
    inherit
      (pkgs.libsForQt5)
      elisa
      kate
      konsole
      ;
  };
}
