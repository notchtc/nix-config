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
            "footclient.desktop"
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

        "org/gnome/mutter" = {
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
        { package = appindicator; }
        { package = window-is-ready-remover; }
      ];
    };
  };
}
