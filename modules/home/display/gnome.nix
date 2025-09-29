{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.mama.desktops.gnome.enable {
    dconf = {
      enable = true;
      settings = with lib.hm.gvariant; {
        "org/gnome/shell" = {
          disable-extension-version-validation = true;
          favorite-apps = [
            "org.gnome.Nautilus.desktop"
            "com.mitchellh.ghostty.desktop"
            "Schizofox.desktop"
            "org.strawberrymusicplayer.strawberry.desktop"
            "org.telegram.desktop.desktop"
            "vesktop.desktop"
            "steam.desktop"
          ];
        };

        "org/gnome/desktop/interface" = {
          show-battery-percentage = true;
        };

        "org/gnome/desktop/privacy" = {
          old-files-age = lib.gvariant.mkUint16 14;
          remember-recent-files = false;
          remove-old-temp-files = true;
          remove-old-trash-files = true;
        };

        "org/gnome/desktop/calendar" = {
          show-weekdate = true;
        };

        "org/gnome/mutter" = {
          experimental-features = [ "variable-refresh-rate" ];
          dynamic-workspaces = true;
          edge-tiling = true;
          workspaces-only-on-primary = true;
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

        "org/gnome/shell/extensions/auto-move-windows" = {
          application-list = [
            "Schizofox.desktop:1"
            "org.telegram.desktop.desktop:2"
            "vesktop.desktop:2"
          ];
        };

        "org/gtk/gtk4/settings/file-chooser" = {
          show-hidden = true;
          sort-directories-first = true;
        };

        "org/gtk/settings/file-chooser" = {
          show-hidden = true;
          sort-directories-first = true;
        };

        "org/gnome/desktop/wm" = {
          resize-with-right-button = true;
        };

        "org/gnome/desktop/peripherals/touchpad" = {
          disable-while-typing = false;
        };

        "org/gnome/settings-daemon/plugins/color" = {
          night-light-enabled = true;
          night-light-schedule-automatic = true;
        };
      };
    };
    programs.gnome-shell = {
      enable = true;
      extensions = with pkgs.gnomeExtensions; [
        { package = alphabetical-app-grid; }
        { package = auto-move-windows; }
        { package = window-is-ready-remover; }
        { package = status-icons; }
      ];
    };
  };
}
