{
  inputs,
  lib,
  osConfig,
  ...
}:
{
  imports = [ "${inputs.plasma-manager.result}/modules/default.nix" ];

  programs.plasma = lib.mkIf osConfig.mama.profiles.graphical.enable {
    enable = true;
    immutableByDefault = true;
    overrideConfig = true;

    workspace = {
      enableMiddleClickPaste = false;
      colorScheme = "ReactionaryCreatures";
      cursor.theme = "Hackneyed";
      iconTheme = "oxygen";
      lookAndFeel = "org.magpie.reactplus.desktop";
      wallpaper = ./wallpaper.jpg;
    };

    desktop = {
      icons.alignment = "right";
      mouseActions = {
        leftClick = "applicationLauncher";
        middleClick = "switchWindow";
      };
    };

    kscreenlocker.appearance.wallpaper = ./wallpaper.jpg;

    krunner.position = "center";

    kwin = {
      nightLight = {
        enable = true;
        temperature.night = 2500;
      };

      titlebarButtons.left = [ "more-window-actions" ];

      virtualDesktops = {
        rows = 1;
        number = 4;
      };
    };

    fonts = {
      general = {
        family = "Iosevka Aile";
        pointSize = 11;
      };

      fixedWidth = {
        family = "Iosevka Term";
        pointSize = 10;
      };

      small = {
        family = "Iosevka Aile";
        pointSize = 8;
      };

      toolbar = {
        family = "Iosevka Aile";
        pointSize = 11;
      };

      menu = {
        family = "Iosevka Aile";
        pointSize = 11;
      };

      windowTitle = {
        family = "Iosevka Aile";
        pointSize = 11;
      };
    };

    panels = [
      {
        alignment = "center";
        floating = false;
        height = 30;
        hiding = "normalpanel";
        lengthMode = "fill";
        location = "left";
        opacity = "opaque";

        widgets = [
          {
            kickoff = {
              compactDisplayStyle = true;
              showActionButtonCaptions = false;
              sortAlphabetically = true;
              applicationsDisplayMode = "list";
              favoritesDisplayMode = "list";
              showButtonsFor = "session";
            };
          }
          {
            iconTasks = {
              launchers = [
                "applications:org.kde.dolphin.desktop"
                "applications:librewolf.desktop"
                "applications:org.strawberrymusicplayer.strawberry.desktop"
                "applications:org.telegram.desktop.desktop"
                "applications:vesktop.desktop"
                "applications:steam.desktop"
              ];
            };
          }
          {
            systemTray = {
              icons.scaleToFit = true;
            };
          }
          {
            name = "split-clock";
            config = {
              Appearance = {
                autoFontAndSize = false;
                fontFamily = "Iosevka Aile";
                fontSize = 9;
                fontStyleName = "Regular";
                fontWeight = 400;
              };
            };
          }
        ];
      }
    ];

    session.sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";

    shortcuts = {
      "services/org.kde.krunner.desktop"."_launch" = [
        "Meta"
        "Search"
      ];

      "services/footclient.desktop"."_launch" = "Meta+Return";
    };

    window-rules = [
      {
        description = "Librewolf";
        match = {
          window-class = {
            value = "librewolf";
            type = "substring";
          };
        };

        apply = {
          desktops = {
            value = "Desktop_1";
            apply = "initially";
          };
        };
      }
      {
        description = "Discord";
        match = {
          window-class = {
            value = "vesktop";
            type = "substring";
          };
        };

        apply = {
          desktops = {
            value = "Desktop_2";
            apply = "initially";
          };
        };
      }
      {
        description = "Telegram";
        match = {
          window-class = {
            value = "telegram";
            type = "substring";
          };
        };

        apply = {
          desktops = {
            value = "Desktop_3";
            apply = "initially";
          };
        };
      }
    ];

    configFile = {
      "baloofilerc"."Basic Settings"."Indexing-Enabled" = false;
      "kactivitymanagerdrc"."Plugins"."org.kde.ActivityManager.ResourceScoringEnabled" = false;
      "krunnerrc"."Plugins"."baloosearchEnabled" = false;
      "plasmanotifyrc"."Notifications"."PopupPosition" = "TopRight";

      "kactivitymanagerd-pluginsrc"."Plugin-org.kde.ActivityManager.Resources.Scoring" = {
        keep-history-for = 1;
        what-to-remember = 2;
      };

      "kdeglobals"."KDE"."AnimationDurationFactor" = 0;
    };
  };
}
