{ pkgs, ... }:
let
  wallpaperImg = pkgs.fetchurl {
    url = "https://simonstalenhag.se/bilderbig/by_housevisit_2560.jpg";
    hash = "sha256-qFRL7znRvKWLpEriE4JlFT2MZR25uV7SKdpxy8Jlyww=";
  };
in
{
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
      clickItemTo = "open";
      cursorTheme = "phinger-cursors";
      iconTheme = "Papirus-Dark";
      lookAndFeel = "com.kde.breezedark.desktop";
      wallpaper = "${wallpaperImg}";
    };

    panels = [
      {
        location = "bottom";
        height = 30;
        floating = true;
        widgets = [
          {
            name = "org.kde.plasma.kickoff";
            config = {
              General.icon = "distributor-logo-nixos";
            };
          }
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
          "org.kde.plasma.marginsseparator"
          "org.kde.plasma.pager"
        ];
      }
    ];

    shortcuts = {
      "org.codeberg.dnkl.foot.desktop"."_launch" = "Ctrl+Alt+T";
    };

    configFile = {
      "kdeglobals"."General"."XftHintStyle".value = "hintslight";
      "kdeglobals"."General"."XftSubPixel".value = "rgb";
      "kdeglobals"."General"."fixed".value = "Iosevka Nerd Font Mono,10,-1,5,50,0,0,0,0,0";
      "kdeglobals"."General"."font".value = "Iosevka Nerd Font,10,-1,5,50,0,0,0,0,0";
      "kdeglobals"."General"."menuFont".value = "Iosevka Nerd Font,10,-1,5,50,0,0,0,0,0";
      "kdeglobals"."General"."smallestReadableFont".value = "Iosevka Nerd Font,8,-1,5,50,0,0,0,0,0";
      "kdeglobals"."General"."toolBarFont".value = "Iosevka Nerd Font,10,-1,5,50,0,0,0,0,0";
      "kdeglobals"."KDE"."AnimationDurationFactor".value = 0;
      "kdeglobals"."WM"."activeFont".value = "Iosevka Nerd Font,10,-1,5,50,0,0,0,0,0";
      "kscreenlockerrc"."Greeter/Wallpaper/org.kde.image/General"."Image".value = "${wallpaperImg}";
      "kscreenlockerrc"."Greeter/Wallpaper/org.kde.image/General"."PreviewImage".value = "${
        wallpaperImg
      }";
      "kwinrc"."Compositing"."LatencyPolicy".value = "Low";
      "kwinrc"."NightColor"."Active".value = true;
      "kwinrc"."NightColor"."NightTemperature".value = 3000;
      "kwinrc"."ModifierOnlyShortcuts"."Meta".value = "org.kde.krunner,/App,,toggleDisplay";
      "kwinrc"."Desktops"."Number".value = 4;
      "kwinrc"."Desktops"."Rows".value = 2;
      "krunnerrc"."General"."FreeFloating".value = true;
      "baloofilerc"."Basic Settings"."Indexing-Enabled".value = false;
      "krunnerrc"."Plugins"."baloosearchEnabled".value = false;
      "plasmanotifyrc"."Notifications"."PopupPosition".value = "TopRight";
    };
  };
}
