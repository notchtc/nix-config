{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [ "${inputs.plasma-manager.result}/modules/default.nix" ];

  config = lib.mkIf config.mama.desktops.plasma.enable {
    gtk = {
      gtk2.force = true;
      theme = {
        name = "Breeze-Dark";
        package = pkgs.kdePackages.breeze-gtk;
      };

      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
    };

    programs.plasma = {
      enable = true;

      workspace = {
        colorScheme = "BreezeDark";
        cursor.theme = "phinger-cursors-dark";
        enableMiddleClickPaste = false;
        iconTheme = "Papirus-Dark";
        lookAndFeel = "org.kde.breezedark.desktop";
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
        nightLight = {
          enable = true;
          mode = "times";

          time = {
            morning = "06:00";
            evening = "20:00";
          };
        };

        virtualDesktops = {
          rows = 2;
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
                icon = "nix-snowflake-white";
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
          };
        }
      ];

      configFile = {
        "baloofilerc"."Basic Settings"."Indexing-Enabled" = false;
        "plasmanotifyrc"."Notifications"."PopupPosition" = "TopRight";
      };
    };
  };
}
