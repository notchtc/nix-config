{ inputs, pkgs, ... }:
{
  imports = [ inputs.plasma-manager.homeManagerModules.plasma-manager ];

  home.packages = [ inputs.self.packages.${pkgs.system}.split-clock ];

  programs.plasma = {
    enable = true;

    fonts = {
      general = {
        family = "sans-serif";
        pointSize = 10;
      };

      fixedWidth = {
        family = "monospace";
        pointSize = 10;
      };

      small = {
        family = "sans-serif";
        pointSize = 8;
      };

      toolbar = {
        family = "sans-serif";
        pointSize = 10;
      };

      menu = {
        family = "sans-serif";
        pointSize = 10;
      };

      windowTitle = {
        family = "sans-serif";
        pointSize = 10;
      };
    };

    input.keyboard = {
      layouts = [ { layout = "pl"; } ];
      repeatDelay = 485;
      repeatRate = 37;
      options = [ "caps:swapescape" ];
    };

    kscreenlocker = {
      autoLock = true;
      lockOnResume = true;
      timeout = 3;
      passwordRequired = true;
      passwordRequiredDelay = 10;
      appearance = {
        alwaysShowClock = true;
        showMediaControls = true;
        wallpaperPictureOfTheDay.provider = "simonstalenhag";
      };
    };

    kwin = {
      borderlessMaximizedWindows = false;

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

      effects = {
        shakeCursor.enable = true;
        translucency.enable = false;
        blur.enable = false;
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

      virtualDesktops = {
        rows = 2;
        number = 4;
      };
    };

    panels = [
      {
        location = "right";
        height = 28;
        floating = true;
        widgets = [
          {
            kickoff = {
              icon = "nix-snowflake-white";

              compactDisplayStyle = true;
              favoritesDisplayMode = "list";
              applicationsDisplayMode = "list";
            };
          }
          "org.kde.plasma.marginsseparator"
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
            systemTray = {
              icons = {
                spacing = "small";
                scaleToFit = true;
              };

              items = {
                hidden = [
                  "org.kde.plasma.addons.katesessions"
                  "org.kde.plasma.clipboard"
                ];
              };
            };
          }
          "org.kde.plasma.marginsseparator"
          {
            name = "split-clock";
            config = {
              Appearance = {
                autoFontAndSize = true;
              };
            };
          }
        ];
      }
    ];

    shortcuts = {
      "services/org.kde.krunner.desktop"."_launch" = [
        "Meta"
        "Search"
      ];

      "services/Alacritty.desktop"."New" = "Meta+Return";
    };

    workspace = {
      clickItemTo = "open";
      cursor.theme = "phinger-cursors-dark";
      iconTheme = "Papirus-Dark";
      lookAndFeel = "org.kde.breezedark.desktop";
      wallpaperPictureOfTheDay.provider = "simonstalenhag";

      desktop.mouseActions = {
        leftClick = "applicationLauncher";
        middleClick = "switchWindow";
      };
    };

    configFile = {
      "kdeglobals"."General"."TerminalApplication" = "alacritty";
      "kdeglobals"."General"."TerminalService" = "Alacritty.desktop";
      "kdeglobals"."KDE"."AnimationDurationFactor" = 0;

      "breezerc"."Common"."ShadowSize" = "ShadowNone";

      "kwinrc"."Compositing"."LatencyPolicy" = "Low";

      "krunnerrc"."General"."FreeFloating" = true;
      "krunnerrc"."Plugins"."baloosearchEnabled" = false;
      "krunnerrc"."Plugins"."browserhistoryEnabled" = false;
      "krunnerrc"."Plugins"."browsertabsEnabled" = false;
      "krunnerrc"."Plugins"."krunner_appstreamEnabled" = false;
      "krunnerrc"."Plugins"."krunner_bookmarksrunnerEnabled" = false;
      "krunnerrc"."Plugins"."krunner_charrunnerENabled" = false;
      "krunnerrc"."Plugins"."krunner_dictionaryEnabled" = false;
      "krunnerrc"."Plugins"."krunner_katesessionsEnabled" = false;
      "krunnerrc"."Plugins"."krunner_konsoleprofilesEnabled" = false;
      "krunnerrc"."Plugins"."krunner_sessionsEnabled" = false;
      "krunnerrc"."Plugins"."krunner_spellcheckEnabled" = false;
      "krunnerrc"."Plugins"."krunner_webshortcutsEnabled" = false;
      "krunnerrc"."Plugins"."org.kde.activities2Enabled" = false;
      "krunnerrc"."Plugins/Favorites"."plugins" = "krunner_services";

      "kwalletrc"."Wallet"."Close When Idle" = true;
      "kwalletrc"."Wallet"."Close on Screensaver" = false;
      "kwalletrc"."Wallet"."Default Wallet" = "kdewallet";
      "kwalletrc"."Wallet"."Enabled" = true;
      "kwalletrc"."Wallet"."First Use" = false;
      "kwalletrc"."Wallet"."Idle Timeout" = 5;
      "kwalletrc"."Wallet"."Launch Manager" = false;
      "kwalletrc"."Wallet"."Leave Manager Open" = false;
      "kwalletrc"."Wallet"."Leave Open" = false;
      "kwalletrc"."Wallet"."Prompt on Open" = false;
      "kwalletrc"."Wallet"."Use One Wallet" = true;
      "kwalletrc"."org.freedesktop.secrets"."apiEnabled" = true;

      "baloofilerc"."Basic Settings"."Indexing-Enabled" = false;

      "plasmanotifyrc"."Notifications"."PopupPosition" = "TopRight";
    };
  };
}
