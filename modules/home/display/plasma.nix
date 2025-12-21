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

    input.keyboard.layouts = [ { layout = osConfig.mama.system.keyMap; } ];
    kscreenlocker.appearance.wallpaper = ./wallpaper.jpg;
    krunner.position = "center";
    session.sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";

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

    kwin = {
      nightLight = {
        enable = true;
        temperature.night = 2500;
      };

      virtualDesktops = {
        rows = 1;
        number = 4;
      };
    };

    fonts = {
      general = {
        family = "sans-serif";
        pointSize = 11;
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
        pointSize = 11;
      };

      menu = {
        family = "sans-serif";
        pointSize = 11;
      };

      windowTitle = {
        family = "sans-serif";
        pointSize = 11;
      };
    };

    panels = [
      {
        alignment = "center";
        floating = true;
        height = 30;
        hiding = "dodgewindows";
        lengthMode = "fill";
        location = "left";

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
              items.hidden = [ "org.kde.plasma.networkmanagement" ];
            };
          }
          {
            name = "split-clock";
            config = {
              Appearance = {
                autoFontAndSize = false;
                fontFamily = "sans-serif";
                fontSize = 10;
                fontStyleName = "Regular";
                fontWeight = 400;
              };
            };
          }
        ];
      }
    ];

    powerdevil = {
      battery.powerProfile = "powerSaving";
      lowBattery.displayBrightness = 10;
    };

    shortcuts = {
      "services/org.kde.krunner.desktop"."_launch" = [
        "Meta"
        "Search"
      ];

      "services/com.mitchellh.ghostty.desktop"."new-window" = "Meta+Return";

      kwin = {
        "Overview" = "Meta+O";
        "Switch to Next Desktop" = "Meta+U";
        "Switch to Previous Desktop" = "Meta+I";
        "Walk Through Windows (Reverse)" = "Alt+Shift+Tab";
        "Walk Through Windows" = "Alt+Tab";
        "Window Close" = "Meta+Q";
        "Window Fullscreen" = "Meta+Shift+F";
        "Window Maximize" = "Meta+F";
        "Window to Next Desktop" = "Meta+Ctrl+U";
        "Window to Previous Desktop" = "Meta+Ctrl+I";
        "Switch to Desktop 1" = "Meta+1";
        "Switch to Desktop 2" = "Meta+2";
        "Switch to Desktop 3" = "Meta+3";
        "Switch to Desktop 4" = "Meta+4";
        "Switch to Desktop 5" = "Meta+5";
        "Switch to Desktop 6" = "Meta+6";
        "Switch to Desktop 7" = "Meta+7";
        "Switch to Desktop 8" = "Meta+8";
        "Switch to Desktop 9" = "Meta+9";

        "karousel-column-move-end" = "Meta+Ctrl+End";
        "karousel-column-move-left" = "Meta+Ctrl+H";
        "karousel-column-move-right" = "Meta+Ctrl+L";
        "karousel-column-move-start" = "Meta+Ctrl+Home";
        "karousel-column-move-to-column-1" = [ ];
        "karousel-column-move-to-column-2" = [ ];
        "karousel-column-move-to-column-3" = [ ];
        "karousel-column-move-to-column-4" = [ ];
        "karousel-column-move-to-column-5" = [ ];
        "karousel-column-move-to-column-6" = [ ];
        "karousel-column-move-to-column-7" = [ ];
        "karousel-column-move-to-column-8" = [ ];
        "karousel-column-move-to-column-9" = [ ];
        "karousel-column-move-to-column-10" = [ ];
        "karousel-column-move-to-column-11" = [ ];
        "karousel-column-move-to-column-12" = [ ];
        "karousel-column-move-to-desktop-1" = "Meta+Ctrl+1";
        "karousel-column-move-to-desktop-2" = "Meta+Ctrl+2";
        "karousel-column-move-to-desktop-3" = "Meta+Ctrl+3";
        "karousel-column-move-to-desktop-4" = "Meta+Ctrl+4";
        "karousel-column-move-to-desktop-5" = "Meta+Ctrl+5";
        "karousel-column-move-to-desktop-6" = "Meta+Ctrl+6";
        "karousel-column-move-to-desktop-7" = "Meta+Ctrl+7";
        "karousel-column-move-to-desktop-8" = "Meta+Ctrl+8";
        "karousel-column-move-to-desktop-9" = "Meta+Ctrl+9";
        "karousel-column-move-to-desktop-10" = [ ];
        "karousel-column-move-to-desktop-11" = [ ];
        "karousel-column-move-to-desktop-12" = [ ];
        "karousel-column-toggle-stacked" = "Meta+X";
        "karousel-column-width-decrease" = "Meta+_";
        "karousel-column-width-increase" = "Meta++";
        "karousel-columns-squeeze-left" = [ ];
        "karousel-columns-squeeze-right" = [ ];
        "karousel-columns-width-equalize" = [ ];
        "karousel-cycle-preset-widths" = "Meta+R";
        "karousel-cycle-preset-widths-reverse" = "Meta+Shift+R";
        "karousel-focus-1" = [ ];
        "karousel-focus-2" = [ ];
        "karousel-focus-3" = [ ];
        "karousel-focus-4" = [ ];
        "karousel-focus-5" = [ ];
        "karousel-focus-6" = [ ];
        "karousel-focus-7" = [ ];
        "karousel-focus-8" = [ ];
        "karousel-focus-9" = [ ];
        "karousel-focus-10" = [ ];
        "karousel-focus-11" = [ ];
        "karousel-focus-12" = [ ];
        "karousel-focus-down" = "Meta+J";
        "karousel-focus-end" = "Meta+End";
        "karousel-focus-left" = "Meta+H";
        "karousel-focus-next" = "Meta+]";
        "karousel-focus-previous" = "Meta+[";
        "karousel-focus-right" = "Meta+L";
        "karousel-focus-start" = "Meta+Home";
        "karousel-focus-up" = "Meta+K";
        "karousel-grid-scroll-end" = [ ];
        "karousel-grid-scroll-focused" = "Mod+C";
        "karousel-grid-scroll-left" = [ ];
        "karousel-grid-scroll-left-column" = [ ];
        "karousel-grid-scroll-right" = [ ];
        "karousel-grid-scroll-right-column" = [ ];
        "karousel-grid-scroll-start" = [ ];
        "karousel-screen-switch" = "Meta+Ctrl+Return";
        "karousel-tail-move-to-desktop-1" = [ ];
        "karousel-tail-move-to-desktop-2" = [ ];
        "karousel-tail-move-to-desktop-3" = [ ];
        "karousel-tail-move-to-desktop-4" = [ ];
        "karousel-tail-move-to-desktop-5" = [ ];
        "karousel-tail-move-to-desktop-6" = [ ];
        "karousel-tail-move-to-desktop-7" = [ ];
        "karousel-tail-move-to-desktop-8" = [ ];
        "karousel-tail-move-to-desktop-9" = [ ];
        "karousel-tail-move-to-desktop-10" = [ ];
        "karousel-tail-move-to-desktop-11" = [ ];
        "karousel-tail-move-to-desktop-12" = [ ];
        "karousel-window-move-down" = "Meta+Shift+J";
        "karousel-window-move-end" = [ ];
        "karousel-window-move-left" = "Meta+Shift+H";
        "karousel-window-move-next" = "Meta+}";
        "karousel-window-move-previous" = "Meta+{";
        "karousel-window-move-right" = "Meta+Shift+L";
        "karousel-window-move-start" = [ ];
        "karousel-window-move-to-column-1" = [ ];
        "karousel-window-move-to-column-2" = [ ];
        "karousel-window-move-to-column-3" = [ ];
        "karousel-window-move-to-column-4" = [ ];
        "karousel-window-move-to-column-5" = [ ];
        "karousel-window-move-to-column-6" = [ ];
        "karousel-window-move-to-column-7" = [ ];
        "karousel-window-move-to-column-8" = [ ];
        "karousel-window-move-to-column-9" = [ ];
        "karousel-window-move-to-column-10" = [ ];
        "karousel-window-move-to-column-11" = [ ];
        "karousel-window-move-to-column-12" = [ ];
        "karousel-window-move-up" = "Meta+Shift+K";
        "karousel-window-toggle-floating" = "Meta+Shift+V";
      };
    };

    configFile = {
      "baloofilerc"."Basic Settings"."Indexing-Enabled" = false;
      "kactivitymanagerdrc"."Plugins"."org.kde.ActivityManager.ResourceScoringEnabled" = false;
      "krunnerrc"."Plugins"."baloosearchEnabled" = false;
      "plasmanotifyrc"."Notifications"."PopupPosition" = "TopRight";

      "kactivitymanagerd-pluginsrc"."Plugin-org.kde.ActivityManager.Resources.Scoring" = {
        keep-history-for = 1;
        what-to-remember = 2;
      };

      "kdeglobals"."KDE" = {
        "AnimationDurationFactor" = 0;
        "AutomaticLookAndFeel" = true;
        "AutomaticLookAndFeelOnIdle" = false;
      };

      "kwinrc" = {
        "Plugins"."karouselEnabled" = true;
        "Script-karousel" = {
          "floatingKeepAbove" = true;
          "gapsInnerHorizontal" = 6;
          "gapsInnerVertical" = 6;
          "gapsOuterBottom" = 6;
          "gapsOuterLeft" = 6;
          "gapsOuterRight" = 6;
          "gapsOuterTop" = 6;
          "gestureScroll" = false;
          "reMaximize" = true;
          "scrollingCentered" = true;
          "scrollingLazy" = false;
          "tiledKeepBelow" = false;
        };
      };
    };
  };
}
