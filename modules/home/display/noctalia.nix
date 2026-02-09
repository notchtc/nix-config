{
  inputs,
  lib,
  osConfig,
  ...
}:
{
  imports = [ inputs.noctalia.result.homeModules.default ];

  programs.noctalia-shell = lib.mkIf osConfig.mama.profiles.graphical.enable {
    enable = true;
    settings = {
      bar = {
        barType = "floating";
        position = "right";
        showCapsule = false;
        floating = true;
        marginVertical = 8;
        marginHorizontal = 8;
        displayMode = "auto_hide";
        widgets = {
          left = [
            {
              id = "Workspace";
              labelMode = "none";
              pillSize = 0.45;
            }
            { id = "Taskbar"; }
          ];
          center = [ ];
          right = [
            { id = "MediaMini"; }
            {
              id = "Tray";
              drawerEnabled = false;
            }
            { id = "NotificationHistory"; }
            {
              id = "Battery";
              hideIfIdle = true;
              showNoctaliaPerformance = true;
              showPowerProfiles = true;
            }
            { id = "Volume"; }
            { id = "Brightness"; }
            { id = "ControlCenter"; }
            {
              id = "Clock";
              formatVertical = "HH mm";
            }
          ];
        };
      };

      ui = {
        panelsAttachedToBar = false;
        settingsPanelMode = "centered";
      };

      audio.visualizerType = "none";
      dock.enabled = false;
      general.enableShadows = false;
      location.weatherEnabled = false;
      notifications.location = "top_left";
      nightLight.enabled = true;
      osd.location = "top";
      wallpaper.overviewEnabled = true;
    };
  };
}
