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
      name = "phinger-cursors-dark";
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

      "kxkbrc"."Layout"."LayoutList".value = "pl";
      "kxkbrc"."Layout"."Options".value = "caps:swapescape";

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
      "kwinrc"."Plugins"."blurEnabled".value = false;

      "krunnerrc"."General"."FreeFloating".value = true;
      "krunnerrc"."Plugins"."baloosearchEnabled".value = false;
      "krunnerrc"."Plugins"."browserhistoryEnabled".value = false;
      "krunnerrc"."Plugins"."browsertabsEnabled".value = false;
      "krunnerrc"."Plugins"."krunner_appstreamEnabled".value = false;
      "krunnerrc"."Plugins"."krunner_bookmarksrunnerEnabled".value = false;
      "krunnerrc"."Plugins"."krunner_charrunnerENabled".value = false;
      "krunnerrc"."Plugins"."krunner_dictionaryEnabled".value = false;
      "krunnerrc"."Plugins"."krunner_katesessionsEnabled".value = false;
      "krunnerrc"."Plugins"."krunner_konsoleprofilesEnabled".value = false;
      "krunnerrc"."Plugins"."krunner_sessionsEnabled".value = false;
      "krunnerrc"."Plugins"."krunner_spellcheckEnabled".value = false;
      "krunnerrc"."Plugins"."krunner_webshortcutsEnabled".value = false;
      "krunnerrc"."Plugins"."org.kde.activities2Enabled".value = false;
      "krunnerrc"."Plugins/Favorites"."plugins".value = "krunner_services";

      "kwalletrc"."Wallet"."Close When Idle".value = true;
      "kwalletrc"."Wallet"."Close on Screensaver".value = false;
      "kwalletrc"."Wallet"."Default Wallet".value = "kdewallet";
      "kwalletrc"."Wallet"."Enabled".value = true;
      "kwalletrc"."Wallet"."First Use".value = false;
      "kwalletrc"."Wallet"."Idle Timeout".value = 5;
      "kwalletrc"."Wallet"."Launch Manager".value = false;
      "kwalletrc"."Wallet"."Leave Manager Open".value = false;
      "kwalletrc"."Wallet"."Leave Open".value = false;
      "kwalletrc"."Wallet"."Prompt on Open".value = false;
      "kwalletrc"."Wallet"."Use One Wallet".value = true;
      "kwalletrc"."org.freedesktop.secrets"."apiEnabled".value = true;

      "baloofilerc"."Basic Settings"."Indexing-Enabled".value = false;

      "plasmanotifyrc"."Notifications"."PopupPosition".value = "TopRight";
    };
  };
}
