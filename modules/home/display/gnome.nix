{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  inherit (config.mama) desktop;
in
{
  config = lib.mkIf (desktop == "gnome") {
    dconf = {
      settings = with lib.hm.gvariant; {
        "org/gnome/shell" = {
          disable-extension-version-validation = true;
          favorite-apps = [
            "org.gnome.Nautilus.desktop"
            "com.mitchellh.ghostty.desktop"
            "Schizofox.desktop"
            "io.github.quodlibet.QuodLibet.desktop"
            "org.telegram.desktop.desktop"
            "vesktop.desktop"
            "steam.desktop"
          ];
        };

        "org/gnome/desktop/app-folders" = {
          folder-children = [ "" ];
        };

        "org/gnome/desktop/background" = {
          picture-uri = "${./wallpaper.jpg}";
          picture-uri-dark = "${./wallpaper.jpg}";
        };

        "org/gnome/desktop/calendar" = {
          show-weekdate = true;
        };

        "org/gnome/desktop/input-sources" = {
          sources = [
            (mkTuple [
              "xkb"
              "pl"
            ])
          ];
          xkb-options = lib.splitString "," osConfig.services.xserver.xkb.options;
        };

        "org/gnome/desktop/interface" = {
          show-battery-percentage = true;
          color-scheme = "prefer-dark";
          cursor-theme = "phinger-cursors-dark";
          document-font-name = "DejaVu Serif 11";
          font-hinting = "none";
          font-name = "Sarasa UI J 11";
          gtk-enable-primary-paste = false;
          gtk-theme = "adw-gtk3-dark";
          monospace-font-name = "Sarasa Term J 10";
          show-battery-percantage = true;
        };

        "org/gnome/desktop/peripherals/touchpad" = {
          disable-while-typing = false;
        };

        "org/gnome/desktop/privacy" = {
          old-files-age = lib.gvariant.mkUint16 14;
          remember-recent-files = false;
          remove-old-temp-files = true;
          remove-old-trash-files = true;
        };

        "org/gnome/desktop/sound" = {
          event-sounds = false;
        };

        "org/gnome/desktop/wm/preferences" = {
          resize-with-right-button = true;
        };

        "org/gnome/mutter" = {
          edge-tiling = true;
          experimental-features = [ "variable-refresh-rate" ];
          dynamic-workspaces = true;
          workspaces-only-on-primary = true;
        };

        "org/gnome/settings-daemon/plugins/color" = {
          night-light-enabled = true;
          night-light-schedule-automatic = true;
        };

        "org/gnome/shell/extensions/auto-move-windows" = {
          application-list = [
            "Schizofox.desktop:1"
            "vesktop.desktop:2"
            "org.telegram.desktop.desktop:3"
          ];
        };

        "org/gnome/shell/extensions/pip-on-top" = {
          stick = true;
        };

        "org/gtk/gtk4/settings/file-chooser" = {
          show-hidden = true;
          sort-directories-first = true;
        };

        "org/gtk/settings/file-chooser" = {
          show-hidden = true;
          sort-directories-first = true;
        };
      };
    };

    gtk = {
      enable = true;
      colorScheme = "dark";

      cursorTheme = {
        name = "phinger-cursors-dark";
        package = pkgs.phinger-cursors;
      };

      font = {
        name = "Sarasa UI J";
        package = pkgs.sarasa-gothic;
        size = 11;
      };

      iconTheme = {
        name = "MoreWaita";
        package = pkgs.morewaita-icon-theme;
      };

      theme = {
        name = "adw-gtk3-dark";
        package = pkgs.adw-gtk3;
      };
    };

    programs.gnome-shell = {
      enable = true;
      extensions = with pkgs.gnomeExtensions; [
        { package = appindicator; }
        { package = auto-move-windows; }
        { package = easyeffects-preset-selector; }
        { package = media-progress; }
        { package = pip-on-top; }
        { package = window-is-ready-remover; }
      ];
    };
  };
}
