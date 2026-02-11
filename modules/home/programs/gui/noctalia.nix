{
  config,
  inputs,
  lib,
  profiles,
  ...
}:
{
  imports = [ inputs.noctalia.result.homeModules.default ];

  programs.noctalia-shell = lib.mkIf profiles.graphical.enable {
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

      controlCenter = {
        shortcuts = {
          left = [
            { id = "Notifications"; }
            { id = "Bluetooth"; }
          ];
          right = [
            { id = "NoctaliaPerformance"; }
            { id = "PowerProfile"; }
            { id = "KeepAwake"; }
            { id = "NightLight"; }
          ];
        };

        cards = [
          {
            id = "profile-card";
            enabled = true;
          }
          {
            id = "shortcuts-card";
            enabled = true;
          }
          {
            id = "audio-card";
            enabled = true;
          }
          {
            id = "brightness-card";
            enabled = true;
          }
          {
            id = "weather-card";
            enabled = false;
          }
          {
            id = "media-sysmon-card";
            enabled = true;
          }
        ];
      };

      general = {
        enableShadows = false;
        showSessionButtonsOnLockScreen = false;
      };

      location = {
        name = "Katowice"; # not doxxing myself lol
        weatherEnabled = false;
      };

      ui = {
        panelsAttachedToBar = false;
        settingsPanelMode = "centered";
      };

      audio.visualizerType = "none";
      dock.enabled = false;
      notifications.location = "top_left";
      nightLight.enabled = true;
      osd.location = "top";
      systemMonitor.externalMonitor = "${config.home.sessionVariables.TERMINAL} -e btm";
      wallpaper.overviewEnabled = true;
    };
  };
}
