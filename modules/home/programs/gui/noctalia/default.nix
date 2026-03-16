{
  inputs,
  lib,
  pkgs,
  profiles,
  ...
}:
{
  imports = [
    inputs.noctalia.result.homeModules.default

    ./bar.nix
    ./control-center.nix
    ./plugins.nix
  ];

  config = lib.mkIf profiles.graphical.enable {
    programs.noctalia-shell = {
      enable = true;
      settings = {
        general = {
          animationDisabled = true;
          avatarImage = ../../../environment/theming/face.jpg;
          clockStyle = "digital";
          dimmerOpacity = 0;
          enableShadows = false;
          showSessionButtonsOnLockScreen = false;
        };

        appLauncher = {
          enableClipboardHistory = true;
          overviewLayer = true;
          terminalCommand = "ghostty -e";
        };

        location = {
          name = "Katowice, PL"; # not doxxing myself lol
          weatherEnabled = false;
        };

        notifications = {
          location = "top_right";
          respectExpireTimeout = true;
        };

        templates = {
          activeTemplates = [
            {
              id = "kcolorscheme";
              enabled = true;
            }
            {
              id = "qt";
              enabled = true;
            }
          ];
        };

        ui = {
          panelsAttachedToBar = false;
          panelBackgroundOpacity = 1;
          settingsPanelMode = "centered";
        };

        audio.visualizerType = "none";
        colorSchemes.predefinedScheme = "ADW";
        dock.enabled = false;
        idle.enabled = true;
        nightLight.enabled = true;
        osd.location = "top";
        systemMonitor.externalMonitor = "ghostty -e btm";
        wallpaper.overviewEnabled = true;
      };
    };

    xdg = {
      configFile."noctalia/colorschemes/ADW/ADW.json".source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/noctalia-dev/noctalia-colorschemes/refs/heads/main/ADW/ADW.json";
        hash = "sha256-KbdBPVuAT4EiPwW+mnKkPLEVUhDaMNksgUGZ0FRi9U4=";
      };
      cacheFile."noctalia/wallpapers.json".text = builtins.toJSON {
        defaultWallpaper = ../../../environment/theming/wallpaper.jpg;
      };
    };
  };
}
