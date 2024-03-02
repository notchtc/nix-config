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
        defaultSession = "plasma";
        autoLogin = {
          enable = true;
          user = "chtc";
        };
      };

      desktopManager.plasma6.enable = true;

      xkb = {
        layout = "pl";
        options = "caps:swapescape";
      };

      excludePackages = [pkgs.xterm];
    };
  };

  environment.plasma6.excludePackages = lib.attrValues {
    inherit
      (pkgs.kdePackages)
      elisa
      konsole
      ;
  };
}
