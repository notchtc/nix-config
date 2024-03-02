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
              sponsorblock
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

          extraConfig = builtins.readFile ./programs/firefox/user.js;
        };
      };
    })
  ];

  home = {
    packages = lib.attrValues {
      inherit
        (pkgs)
        vesktop
        strawberry-qt6
        qbittorrent
        gimp
        keepassxc
        easyeffects
        trash-cli
        telegram-desktop
        picard
        sd-switch
        wl-clipboard
        nil
        marksman
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
      VDPAU_DRIVER = "va_gl";
      WINEPREFIX = "${config.xdg.dataHome}/wine";
      _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=${config.xdg.configHome}/java";
      GNUPGHOME = "${config.programs.gpg.homedir}";
      LESSHISTFILE = "-";
      BROWSER = "firefox";
      PAGER = "less";
      TERMINAL = "foot";
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

    desktopEntries = {
      vesktop = {
        name = "Vesktop";
        genericName = "Internet Messenger";
        exec = "vesktop --enable-features=VaapiIgnoreDriverChecks,VaapiVideoEncoder,VaapiVideoDecoder,CanvasOopRasterization,UseMultiPlaneFormatForHardwareVideo";
        terminal = false;
        categories = ["Network" "InstantMessaging" "Chat"];
        icon = "vesktop";
      };
    };
  };

  gtk.gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

  programs = {
    yt-dlp.enable = true;
    gpg.homedir = "${config.xdg.dataHome}/gnupg";
    bash.historyFile = "${config.xdg.stateHome}/bash/history";

    foot = {
      enable = true;

      settings = {
        main = {
          font = "monospace:size=10";
          dpi-aware = "yes";
          pad = "3x3 center";
        };

        cursor = {
          style = "beam";
          blink = "yes";
        };

        colors = {
          background = "1d2021";
          foreground = "d4be98";
          regular0 = "32302f";
          regular1 = "ea6962";
          regular2 = "a9b665";
          regular3 = "d8a657";
          regular4 = "7daea3";
          regular5 = "d3869b";
          regular6 = "89b482";
          regular7 = "d4be98";
          bright0 = "32302f";
          bright1 = "ea6962";
          bright2 = "a9b665";
          bright3 = "d8a657";
          bright4 = "7daea3";
          bright5 = "d3869b";
          bright6 = "89b482";
          bright7 = "d4be98";
        };
      };
    };
  };

  systemd.user.startServices = "sd-switch";
}
