{
  config,
  inputs,
  lib,
  ...
}:
{
  imports = [ "${inputs.plasma-manager.result}/modules/default.nix" ];

  config = lib.mkIf config.mama.desktops.plasma.enable {
    programs.plasma = {
      enable = true;
      immutableByDefault = true;
      overrideConfig = true;

      workspace = {
        enableMiddleClickPaste = false;
        wallpaper = ./wallpaper.jpg;
      };

      desktop = {
        icons.alignment = "right";
        mouseActions = {
          leftClick = "applicationLauncher";
          middleClick = "switchWindow";
        };
      };

      kscreenlocker = {
        appearance.wallpaper = ./wallpaper.jpg;
      };

      krunner = {
        position = "center";
      };

      kwin = {
        virtualDesktops = {
          rows = 1;
          number = 4;
        };
      };

      fonts = {
        general = {
          family = "Sarasa UI J";
          pointSize = 11;
        };

        fixedWidth = {
          family = "Sarasa Term J";
          pointSize = 10;
        };

        small = {
          family = "Sarasa UI J";
          pointSize = 8;
        };

        toolbar = {
          family = "Sarasa UI J";
          pointSize = 10;
        };

        menu = {
          family = "Sarasa UI J";
          pointSize = 10;
        };

        windowTitle = {
          family = "Sarasa UI J";
          pointSize = 10;
        };
      };

      panels = [
        {
          alignment = "center";
          floating = true;
          height = 30;
          hiding = "dodgewindows";
          lengthMode = "fill";
          location = "top";

          widgets = [
            {
              kickoff = {
                compactDisplayStyle = true;
                showActionButtonCaptions = false;
                sortAlphabetically = true;
                applicationsDisplayMode = "list";
                favoritesDisplayMode = "list";
                icon = "nix-snowflake";
                showButtonsFor = "session";
              };
            }
            {
              iconTasks = {
                launchers = [
                  "applications:org.kde.dolphin.desktop"
                  "applications:Schizofox.desktop"
                  "applications:org.strawberrymusicplayer.strawberry.desktop"
                  "applications:org.telegram.desktop.desktop"
                  "applications:vesktop.desktop"
                  "applications:steam.desktop"
                ];
              };
            }
            {
              panelSpacer = {
                expanding = true;
              };
            }
            {
              digitalClock = {
                date.format.custom = "ddd d MMM yyyy";
                time.format = "24h";
              };
            }
            {
              panelSpacer = {
                expanding = true;
              };
            }
            {
              systemTray = {
                icons.scaleToFit = true;
              };
            }
          ];
        }
      ];

      session = {
        sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";
      };

      shortcuts = {
        "services/org.kde.krunner.desktop"."_launch" = [
          "Meta"
          "Search"
        ];

        "services/com.mitchellh.ghostty.desktop"."new-window" = "Meta+Return";
      };

      window-rules = [
        {
          description = "Schizofox";
          match = {
            window-class = {
              value = "firefox";
              type = "substring";
            };
          };

          apply = {
            desktopfile = {
              value = "Schizofox";
              apply = "force";
            };

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
        "kwinrc"."NightColor"."Active" = true;
        "krunnerrc"."Plugins"."baloosearchEnabled" = false;
        "plasmanotifyrc"."Notifications"."PopupPosition" = "TopRight";

        "kactivitymanagerd-pluginsrc"."Plugin-org.kde.ActivityManager.Resources.Scoring" = {
          keep-history-for = 1;
          what-to-remember = 2;
        };

        "kdeglobals"."KDE" = {
          "AutomaticLookAndFeel" = true;
          "AutomaticLookAndFeelOnIdle" = false;
        };
      };
    };
  };
}
