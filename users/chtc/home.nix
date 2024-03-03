{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./desktops/plasma.nix
    ../../modules/home-manager/xdg.nix
    ../../modules/home-manager/programs/terminals/foot.nix
    ../../modules/home-manager/programs/mpv

    (import ../../modules/home-manager/programs/browsers/firefox {
      inherit config pkgs;
      package = pkgs.firefox;

      profiles = {
        Default = {
          extensions = lib.attrValues {
            inherit
              (config.nur.repos.rycee.firefox-addons)
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

    username = "chtc";
    homeDirectory = "/home/${config.home.username}";
    stateVersion = "23.11";
  };

  xdg = {
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
  };

  systemd.user.startServices = "sd-switch";
}
