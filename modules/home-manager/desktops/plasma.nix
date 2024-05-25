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
      gtk-application-prefer-dark-theme = 1;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
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
            digitalClock = {
              date.enable = false;
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
      "kdeglobals"."General"."XftHintStyle" = "hintslight";
      "kdeglobals"."General"."XftSubPixel" = "rgb";
      "kdeglobals"."General"."fixed" = "Iosevka Nerd Font Mono,10,-1,5,50,0,0,0,0,0";
      "kdeglobals"."General"."font" = "Iosevka Nerd Font,10,-1,5,50,0,0,0,0,0";
      "kdeglobals"."General"."menuFont" = "Iosevka Nerd Font,10,-1,5,50,0,0,0,0,0";
      "kdeglobals"."General"."smallestReadableFont" = "Iosevka Nerd Font,8,-1,5,50,0,0,0,0,0";
      "kdeglobals"."General"."toolBarFont" = "Iosevka Nerd Font,10,-1,5,50,0,0,0,0,0";
      "kdeglobals"."General"."TerminalApplication" = "foot";
      "kdeglobals"."General"."TerminalService" = "org.codeberg.dnkl.foot.desktop";
      "kdeglobals"."KDE"."AnimationDurationFactor" = 0;
      "kdeglobals"."WM"."activeFont" = "Iosevka Nerd Font,10,-1,5,50,0,0,0,0,0";

      "kxkbrc"."Layout"."LayoutList" = "pl";
      "kxkbrc"."Layout"."Options" = "caps:swapescape";

      "kscreenlockerrc"."Greeter/Wallpaper/org.kde.image/General"."Image" = "${wallpaperImg}";
      "kscreenlockerrc"."Greeter/Wallpaper/org.kde.image/General"."PreviewImage" = "${wallpaperImg}";

      "kwinrc"."Compositing"."LatencyPolicy" = "Low";
      "kwinrc"."NightColor"."Active" = true;
      "kwinrc"."NightColor"."NightTemperature" = 3000;
      "kwinrc"."ModifierOnlyShortcuts"."Meta" = "org.kde.krunner,/App,,toggleDisplay";
      "kwinrc"."Desktops"."Number" = 4;
      "kwinrc"."Desktops"."Rows" = 2;
      "kwinrc"."Plugins"."blurEnabled" = false;

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
