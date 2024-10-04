{
  programs.plasma = {
    kwin = {
      borderlessMaximizedWindows = true;

      effects = {
        desktopSwitching.animation = "off";
        minimization.animation = "off";
        windowOpenClose.animation = "off";

        blur.enable = false;
        dimAdminMode.enable = true;
        shakeCursor.enable = true;
        translucency.enable = false;
      };

      nightLight = {
        enable = true;
        mode = "times";

        time = {
          morning = "06:00";
          evening = "19:50";
        };

        temperature.night = 2500;
      };

      titlebarButtons = {
        left = [
          "more-window-actions"
          "help"
        ];
        right = [
          "minimize"
          "maximize"
          "close"
        ];
      };

      virtualDesktops = {
        rows = 2;
        number = 2;
      };
    };

    configFile."kwinrc"."Effect-overview"."BorderActivate" = 5;
  };
}
