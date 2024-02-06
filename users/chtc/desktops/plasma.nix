{pkgs, ...}: let
  wallpaperImg = pkgs.fetchurl {
    url = "https://unsplash.com/photos/fdiXdOdYtLE/download?ixid=M3wxMjA3fDB8MXxhbGx8Mjg4fHx8fHx8Mnx8MTcwNzI0MDg3Nnw&force=true";
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
      name = "Materia-dark";
      package = pkgs.materia-theme;
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
      theme = "Materia";
      colorScheme = "MateriaDark";
      cursorTheme = "phinger-cursors";
      iconTheme = "Papirus-Dark";
      lookAndFeel = "com.github.varlesh.materia-dark";
      wallpaper = "${wallpaperImg}";
    };

    panels = [
      {
        location = "top";
        height = 30;
        widgets = [
          "org.kde.plasma.kickoff"
          "org.kde.plasma.pager"
          {
            name = "org.kde.plasma.icontasks";
            config = {
              General.launchers = [
                "applications:org.kde.dolphin.desktop"
                "applications:firefox.desktop"
                "applications:org.strawberrymusicplayer.strawberry.desktop"
                "applications:org.telegram.desktop.desktop"
                "applications:armcord.desktop"
                "applications:steam.desktop"
              ];
            };
          }
          "org.kde.plasma.marginseparator"
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

    configFile = {
      "kdeglobals"."General"."XftHintStyle" = "hintslight";
      "kdeglobals"."General"."XftSubPixel" = "rgb";
      "kdeglobals"."General"."fixed" = "Iosevka Nerd Font Mono,10,-1,5,50,0,0,0,0,0";
      "kdeglobals"."General"."font" = "Iosevka Nerd Font,10,-1,5,50,0,0,0,0,0";
      "kdeglobals"."General"."menuFont" = "Iosevka Nerd Font,10,-1,5,50,0,0,0,0,0";
      "kdeglobals"."General"."smallestReadableFont" = "Iosevka Nerd Font,8,-1,5,50,0,0,0,0,0";
      "kdeglobals"."General"."toolBarFont" = "Iosevka Nerd Font,10,-1,5,50,0,0,0,0,0";
      "kdeglobals"."KDE"."AnimationDurationFactor" = 0;
      "kdeglobals"."KFileDialog Settings"."Allow Expansion" = false;
      "kdeglobals"."KFileDialog Settings"."Automatically select filename extension" = true;
      "kdeglobals"."KFileDialog Settings"."Breadcrumb Navigation" = true;
      "kdeglobals"."KFileDialog Settings"."Decoration position" = 2;
      "kdeglobals"."KFileDialog Settings"."LocationCombo Completionmode" = 5;
      "kdeglobals"."KFileDialog Settings"."PathCombo Completionmode" = 5;
      "kdeglobals"."KFileDialog Settings"."Show Bookmarks" = false;
      "kdeglobals"."KFileDialog Settings"."Show Full Path" = false;
      "kdeglobals"."KFileDialog Settings"."Show Inline Previews" = true;
      "kdeglobals"."KFileDialog Settings"."Show Preview" = false;
      "kdeglobals"."KFileDialog Settings"."Show Speedbar" = true;
      "kdeglobals"."KFileDialog Settings"."Show hidden files" = false;
      "kdeglobals"."KFileDialog Settings"."Sort by" = "Name";
      "kdeglobals"."KFileDialog Settings"."Sort directories first" = true;
      "kdeglobals"."KFileDialog Settings"."Sort hidden files last" = false;
      "kdeglobals"."KFileDialog Settings"."Sort reversed" = false;
      "kdeglobals"."KFileDialog Settings"."Speedbar Width" = 147;
      "kdeglobals"."KFileDialog Settings"."View Style" = "DetailTree";
      "kdeglobals"."MainToolbarIcons"."Size" = 16;
      "kdeglobals"."ToolbarIcons"."Size" = 16;
      "kdeglobals"."WM"."activeBackground" = "39,39,39";
      "kdeglobals"."WM"."activeBlend" = "39,39,39";
      "kdeglobals"."WM"."activeFont" = "Iosevka Nerd Font,10,-1,5,50,0,0,0,0,0";
      "kdeglobals"."WM"."activeForeground" = "223,223,223";
      "kdeglobals"."WM"."inactiveBackground" = "30,30,30";
      "kdeglobals"."WM"."inactiveBlend" = "30,30,30";
      "kdeglobals"."WM"."inactiveForeground" = "139,139,139";
      "kscreenlockerrc"."Greeter.Wallpaper.org.kde.image.General"."Image" = "${wallpaperImg}";
      "kscreenlockerrc"."Greeter.Wallpaper.org.kde.image.General"."PreviewImage" = "${wallpaperImg}";
      "kwinrc"."Compositing"."LatencyPolicy" = "Low";
      "kwinrc"."NightColor"."Active" = true;
      "kwinrc"."NightColor"."NightTemperature" = 3000;
      "kwinrc"."org.kde.kdecoration2"."BorderSizeAuto" = false;
      "systemsettingsrc"."KFileDialog Settings"."detailViewIconSize" = 16;
      "systemsettingsrc"."Main"."ActiveView" = "systemsettings_icon_mode";
    };
  };
}
