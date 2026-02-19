{
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
        position = "left";
        showCapsule = false;
        floating = false;
        marginVertical = 8;
        marginHorizontal = 8;
        outerCorners = true;
        displayMode = "always_visible";
        widgets = {
          left = [
            {
              id = "Workspace";
              labelMode = "none";
              pillSize = 0.45;
            }
            { id = "plugin:privacy-indicator"; }
          ];
          center = [ ];
          right = [
            { id = "MediaMini"; }
            {
              id = "Tray";
              drawerEnabled = false;
            }
            { id = "NotificationHistory"; }
            { id = "Brightness"; }
            {
              id = "Battery";
              hideIfIdle = true;
              showNoctaliaPerformance = true;
              showPowerProfiles = true;
            }
            { id = "Volume"; }
            {
              id = "Clock";
              formatVertical = "HH mm";
            }
            {
              id = "ControlCenter";
              useDistroLogo = true;
            }
          ];
        };
      };

      appLauncher = {
        enableClipboardHistory = true;
        iconMode = "native";
        terminalCommand = "ghostty -e";
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
        avatarImage = ../../environment/face.jpg;
        clockStyle = "digital";
        enableShadows = false;
        showSessionButtonsOnLockScreen = false;
      };

      location = {
        name = "Katowice, Poland"; # not doxxing myself lol
        weatherEnabled = false;
      };

      ui = {
        panelsAttachedToBar = false;
        settingsPanelMode = "centered";
      };

      audio.visualizerType = "none";
      dock.enabled = false;
      notifications.location = "top_right";
      nightLight.enabled = true;
      osd.location = "top";
      systemMonitor.externalMonitor = "ghostty -e btm";
      wallpaper.overviewEnabled = true;

      plugins.autoUpdate = true;
    };

    plugins = {
      sources = [
        {
          enabled = true;
          name = "Noctalia Plugins";
          url = "https://github.com/noctalia-dev/noctalia-plugins";
        }
      ];

      states = [
        {
          kaomoji-provider = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
        }
        {
          privacy-indicator = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
        }
      ];
    };

    pluginSettings = {
      privacy-indicator = {
        hideInactive = true;
        iconSpacing = 4;
        removeMargins = false;
        activeColor = "primary";
        inactiveColor = "none";
      };
    };
  };
}
