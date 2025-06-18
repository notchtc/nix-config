{ lib, pkgs, ... }:
{
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
          "com.github.wwmm.easyeffects.desktop"
        ];
      };

      "org/gnome/desktop/interface" = {
        show-battery-percentage = true;
      };

      "org/gnome/mutter" = {
        edge-tiling = true;
        dynamic-workspaces = true;
        workspaces-only-on-primary = true;
      };

      "org/gnome/desktop/input-sources" = {
        sources = [
          (mkTuple [
            "xkb"
            "pl"
          ])
        ];
        xkb-options = [
          "terminate:ctrl_alt_bksp"
          "lv3:ralt_switch"
          "caps:swapescape"
        ];
      };

      "org/gnome/desktop/wm/keybindings" = {
        switch-windows = [ "<Alt>Tab" ];
        switch-windows-backward = [ "<Shift><Alt>Tab" ];
        switch-applications = [ ];
        switch-applications-backward = [ ];
        switch-group = [ ];
        switch-group-backward = [ ];
      };

      "org/gnome/settings-daemon/plugins/color".night-light-enabled = true;
      "org/gnome/nautilus/preferences".click-policy = "single";
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
}
