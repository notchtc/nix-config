{pkgs, ...}: let
  wallpaperImg = pkgs.fetchurl {
    url = "https://unsplash.com/photos/fdiXdOdYtLE/download?ixid=M3wxMjA3fDB8MXxhbGx8Mjg4fHx8fHx8Mnx8MTcwNzI0MDg3Nnw";
    name = "wall.jpg";
    hash = "sha256-uN8LwLPB8GJ3MmkbgjociePtPNImcbq3VSpmTpW91wc=";
  };
in {
  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    theme = {
      name = "Breeze-Dark";
      package = pkgs.kdePackages.breeze-gtk;
    };

    cursorTheme = {
      name = "phinger-cursors";
      package = pkgs.phinger-cursors;
    };

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  programs.plasma = {
    enable = true;

    workspace = {
      cursorTheme = "phinger-cursors";
      iconTheme = "Papirus-Dark";
      lookAndFeel = "com.kde.breezedark.desktop";
      wallpaper = "${wallpaperImg}";
    };

    panels = [
      {
        location = "bottom";
        height = 30;
        widgets = [
          {
            name = "org.kde.plasma.kickoff";
            config = {
              General.icon = "distributor-logo-nixos";
            };
          }
          "org.kde.plasma.pager"
          "org.kde.plasma.marginsseparator"
          {
            name = "org.kde.plasma.icontasks";
            config = {
              General.launchers = [
                "applications:org.kde.dolphin.desktop"
                "applications:firefox.desktop"
                "applications:org.strawberrymusicplayer.strawberry.desktop"
                "applications:org.telegram.desktop.desktop"
                "applications:vesktop.desktop"
                "applications:steam.desktop"
              ];
            };
          }
          "org.kde.plasma.panelspacer"
          {
            name = "org.kde.plasma.digitalclock";
            config = {
              Appearance.showDate = "false";
            };
          }
          "org.kde.plasma.panelspacer"
          "org.kde.plasma.systemtray"
        ];
      }
    ];

    shortcuts = {
      "org.codeberg.dnkl.foot.desktop"."_launch" = "Ctrl+Alt+T";
    };

    configFile = {
      "kdeglobals"."General"."XftHintStyle" = "hintslight";
      "kdeglobals"."General"."XftSubPixel" = "rgb";
      "kdeglobals"."General"."fixed" = "Iosevka Nerd Font Mono,10,-1,5,50,0,0,0,0,0";
      "kdeglobals"."General"."font" = "Iosevka Nerd Font,10,-1,5,50,0,0,0,0,0";
      "kdeglobals"."General"."menuFont" = "Iosevka Nerd Font,10,-1,5,50,0,0,0,0,0";
      "kdeglobals"."General"."smallestReadableFont" = "Iosevka Nerd Font,8,-1,5,50,0,0,0,0,0";
      "kdeglobals"."General"."toolBarFont" = "Iosevka Nerd Font,10,-1,5,50,0,0,0,0,0";
      "kdeglobals"."KDE"."AnimationDurationFactor" = 0;
      "kdeglobals"."WM"."activeFont" = "Iosevka Nerd Font,10,-1,5,50,0,0,0,0,0";
      "kscreenlockerrc"."Greeter.Wallpaper.org.kde.image.General"."Image" = "${wallpaperImg}";
      "kscreenlockerrc"."Greeter.Wallpaper.org.kde.image.General"."PreviewImage" = "${wallpaperImg}";
      "kwinrc"."Compositing"."LatencyPolicy" = "Low";
      "kwinrc"."NightColor"."Active" = true;
      "kwinrc"."NightColor"."NightTemperature" = 3000;
      "kwinrc"."ModifierOnlyShortcuts"."Meta" = "org.kde.krunner,/App,,toggleDisplay";
      "krunnerrc"."General"."FreeFloating" = true;
      "baloofilerc"."Basic Settings"."Indexing-Enabled" = false;
      "krunnerrc"."Plugins"."baloosearchEnabled" = false;
      "plasmanotifyrc"."Notifications"."PopupPosition" = "TopRight";
    };
  };
}
