{ lib, pkgs, ... }:
let
  wallpaperImg = pkgs.fetchurl {
    url = "https://simonstalenhag.se/bilderbig/by_housevisit_2560.jpg";
    hash = "sha256-qFRL7znRvKWLpEriE4JlFT2MZR25uV7SKdpxy8Jlyww=";
  };
in
{
  home.packages = lib.attrValues {
    inherit (pkgs.gnome) gnome-tweaks;
    inherit (pkgs.gnomeExtensions) alphabetical-app-grid appindicator;
  };

  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
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

  qt = {
    enable = true;
    platformTheme = "gnome";
    style.name = "adwaita-dark";
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [
          "AlphabeticalAppGrid@stuarthayhurst"
          "appindicatorsupport@rgcjonas.gmail.com"
          "drive-menu@gnome-shell-extensions.gcampax.github.com"
          "native-window-placement@gnome-shell-extensions.gcampax.github.com"
        ];

        favorite-apps = [
          "firefox.desktop"
          "org.gnome.Console.desktop"
          "io.github.quodlibet.QuodLibet.desktop"
          "org.telegram.desktop.desktop"
          "armcord.desktop"
          "steam.desktop"
          "org.gnome.Nautilus.desktop"
        ];
      };
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        monospace-font-name = "Iosevka Nerd Font Mono 10";
        document-font-name = "Iosevka Nerd Font 11";
        font-name = "Iosevka Nerd Font 10";
        font-antialiasing = "rgba";
        enable-animations = false;
        show-battery-percentage = true;
      };
      "org/gnome/mutter" = {
        edge-tiling = true;
        dynamic-workspaces = true;
      };
      "org/gnome/desktop/wm/keybindings" = {
        switch-windows = [ "<Alt>Tab" ];
        switch-windows-backward = [ "<Shift><Alt>Tab" ];
        switch-applications = [ ];
        switch-applications-backward = [ ];
        switch-group = [ ];
        switch-group-backward = [ ];
      };
      "org/gnome/desktop/wm/preferences".titlebar-font = "Iosevka Nerd Font Ultra-Bold 11";
      "org/gnome/desktop/background".picture-uri = "file://${wallpaperImg}";
      "org/gnome/desktop/background".picture-uri-dark = "file://${wallpaperImg}";
      "org/gnome/desktop/screensaver".picture-uri = "file://${wallpaperImg}";
      "org/gnome/desktop/sound".event-sounds = false;
      "org/gnome/settings-daemon/plugins/color".night-light-enabled = true;
      "org/gnome/nautilus/preferences".click-policy = "single";
    };
  };
}
