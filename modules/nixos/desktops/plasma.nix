{
  lib,
  pkgs,
  ...
}: {
  services = {
    xserver = {
      enable = true;

      displayManager = {
        sddm = {
          enable = true;
          wayland.enable = true;
        };
        defaultSession = "plasmawayland";
        autoLogin = {
          enable = true;
          user = "chtc";
        };
      };

      desktopManager.plasma5.enable = true;

      xkb = {
        layout = "pl";
        options = "caps:swapescape";
      };

      excludePackages = [pkgs.xterm];
    };
  };

  environment.plasma5.excludePackages = lib.attrValues {
    inherit
      (pkgs.libsForQt5)
      elisa
      konsole
      ;
  };
}
