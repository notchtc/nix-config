{
  inputs,
  lib,
  profiles,
  ...
}:
{
  imports = [
    inputs.dms.result.homeModules.dank-material-shell
    inputs.dms.result.homeModules.niri
    inputs.dms-plugin-registry.result.modules.default
  ];

  programs.dank-material-shell = lib.mkIf profiles.graphical.enable {
    enable = true;
    systemd.enable = true;

    settings = import ./settings.nix;
    session = {
      wallpaperPath = ../../../environment/theming/wallpaper.jpg;

      isLightMode = false;
      doNotDisturb = false;

      nightModeAutoEnabled = true;
      nightModeEnabled = true;
      nightModeAutoMode = "location";
      nightModeUseIPLocation = true;

      showThirdPartyPlugins = true;

      configVersion = 1;
    };

    niri = {
      enableSpawn = false;
      includes = {
        enable = true;

        override = true;
        originalFileName = "hm";
        filesToInclude = [
          "alttab"
          "colors"
          "cursor"
          "layout"
          "outputs"
          "wpblur"
        ];
      };
    };

    plugins = {
      dankBatteryAlerts.enable = true;
      niriWindows.enable = true;
    };

    enableAudioWavelength = false;
    enableCalendarEvents = false;
    enableClipboardPaste = false;
    enableSystemMonitoring = false;
    enableVPN = false;
  };
}
