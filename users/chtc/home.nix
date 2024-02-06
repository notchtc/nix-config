{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./desktops/plasma.nix
    ../../modules/home-manager/programs/mpv

    (import ../../modules/home-manager/programs/firefox {
      inherit config pkgs;
      package = pkgs.firefox;

      profiles = {
        Default = {
          extensions = lib.attrValues {
            inherit
              (pkgs.nur.repos.rycee.firefox-addons)
              ublock-origin
              skip-redirect
              enhanced-h264ify
              multi-account-containers
              plasma-integration
              ;
          };

          id = 0;

          search = {
            default = "DuckDuckGo";
            force = true;
          };

          userChrome = ''
            #webrtcIndicator {
              display: none;
            }
          '';

          extraConfig = __readFile ./programs/firefox/user.js;
        };
      };
    })
  ];

  home = {
    packages = lib.attrValues {
      inherit
        (pkgs)
        armcord
        strawberry
        qbittorrent
        gimp
        keepassxc
        easyeffects
        pfetch
        trash-cli
        telegram-desktop
        picard
        sd-switch
        materia-kde-theme
        ;
      inherit
        (pkgs.libsForQt5)
        qtstyleplugin-kvantum
        ;
      # inherit
      #   (pkgs.gnome)
      #   gnome-tweaks
      #   ;
      # inherit
      #   (pkgs.gnomeExtensions)
      #   alphabetical-app-grid
      #   appindicator
      #   ;
    };

    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      GNUPGHOME = "${config.xdg.dataHome}/gnupg";
      GTK2_RC_FILES = lib.mkForce "${config.xdg.configHome}/gtk-2.0/gtkrc";
      WINEPREFIX = "${config.xdg.dataHome}/wine";
      _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=${config.xdg.configHome}/java";
      LESSHISTFILE = "-";
      BROWSER = "firefox";
      EDITOR = "hx";
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
