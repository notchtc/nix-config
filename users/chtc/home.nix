{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./desktops/gnome.nix
    ../../modules/home-manager/programs/mpv

    (import ../../modules/home-manager/programs/firefox {
      inherit config pkgs;
      package = pkgs.firefox;

      arkenfox = {
        enable = true;
        version = "119.0";
      };

      profiles = {
        Default = {
          extensions = lib.attrValues {
            inherit
              (pkgs.nur.repos.rycee.firefox-addons)
              ublock-origin
              skip-redirect
              enhanced-h264ify
              multi-account-containers
              ;
          };

          id = 0;

          userChrome = ''
            #webrtcIndicator {
              display: none;
            }
          '';

          arkenfox = {
            enable = true;
            "0000".enable = true;
            "0100".enable = true;
            "0200".enable = true;
            "0300".enable = true;
            "0400" = {
              enable = true;
              "0401" = {
                "browser.safebrowsing.malware.enabled".value = false;
                "browser.safebrowsing.phishing.enabled".value = false;
              };
              "0402"."browser.safebrowsing.downloads.enabled".value = false;
            };
            "0600".enable = true;
            "0700".enable = true;
            "0800" = {
              enable = true;
              "0803" = {
                "browser.search.suggest.enabled".value = true;
                "browser.urlbar.suggest.searches".value = true;
              };
            };
            "0900".enable = true;
            "1000".enable = true;
            "1200".enable = true;
            "1600".enable = true;
            "1700".enable = true;
            "2000".enable = true;
            "2400".enable = true;
            "2600".enable = true;
            "2700".enable = true;
            "2800".enable = true;
            "4500" = {
              enable = true;
              "4504"."privacy.resistFingerprinting.letterboxing".value = false;
            };
            "6000".enable = true;
          };
        };
      };
    })
  ];

  home = {
    packages = lib.attrValues {
      inherit
        (pkgs)
        armcord
        quodlibet
        qbittorrent
        gimp
        keepassxc
        easyeffects
        pfetch
        trash-cli
        telegram-desktop
        picard
        sd-switch
        ;
      inherit
        (pkgs.gnome)
        gnome-tweaks
        ;
      inherit
        (pkgs.gnomeExtensions)
        alphabetical-app-grid
        appindicator
        ;
    };

    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      GNUPGHOME = "${config.xdg.dataHome}/gnupg";
      GTK2_RC_FILES = lib.mkDefault "${config.xdg.configHome}/gtk-2.0/gtkrc";
      WINEPREFIX = "${config.xdg.dataHome}/wine";
      _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=${config.xdg.configHome}/java";
      LESSHISTFILE = "-";
      BROWSER = "firefox";
      EDITOR = "vim";
      PAGER = "less";
      TERMINAL = "konsole";
    };

    stateVersion = "23.11";
  };

  xdg = {
    enable = true;
    cacheHome = "${config.home.homeDirectory}/.cache";
    configHome = "${config.home.homeDirectory}/.config";
    dataHome = "${config.home.homeDirectory}/.local/share";
    stateHome = "${config.home.homeDirectory}/.local/state";
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "${config.home.homeDirectory}/Desktop";
      documents = "${config.home.homeDirectory}/Documents";
      download = "${config.home.homeDirectory}/Downloads";
      music = "${config.home.homeDirectory}/Music";
      pictures = "${config.home.homeDirectory}/Pictures";
      publicShare = "${config.home.homeDirectory}/Public";
      templates = "${config.home.homeDirectory}/Templates";
      videos = "${config.home.homeDirectory}/Videos";
    };
  };

  programs = {
    yt-dlp.enable = true;
  };

  systemd.user.startServices = "sd-switch";
}
