{
  lib,
  config,
  pkgs,
  ...
}:
{
  home = {
    packages = lib.attrValues {
      inherit (pkgs)
        gimp
        jamesdsp
        keepassxc
        lutris
        nicotine-plus
        picard
        plugdata
        qbittorrent
        strawberry-qt6
        telegram-desktop
        vesktop
        ;
    };

    sessionVariables = {
      _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=${config.xdg.configHome}/java";
      BROWSER = "firefox";
      GNUPGHOME = "${config.programs.gpg.homedir}";
      LESSHISTFILE = "-";
      NIXOS_OZONE_WL = "1";
      PAGER = "less";
      TERMINAL = "foot";
      VDPAU_DRIVER = "va_gl";
      WGETRC = "${config.xdg.configHome}/wgetrc";
      WINEPREFIX = "${config.xdg.dataHome}/wine";
    };

    username = "chtc";
    homeDirectory = "/home/${config.home.username}";
    stateVersion = lib.mkDefault "23.11";
  };

  xdg = {
    configFile = {
      "wgetrc" = {
        enable = true;
        text = ''
          hsts-file \= ${config.xdg.cacheHome}/wget-hsts
        '';
      };
    };

    desktopEntries = {
      vesktop = {
        name = "Vesktop";
        genericName = "Internet Messenger";
        exec = "vesktop --enable-features=VaapiIgnoreDriverChecks,VaapiVideoEncoder,VaapiVideoDecoder,CanvasOopRasterization,UseMultiPlaneFormatForHardwareVideo";
        terminal = false;
        categories = [
          "Network"
          "InstantMessaging"
          "Chat"
        ];
        icon = "vesktop";
      };
    };
  };

  gtk.gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

  programs = {
    git = {
      userName = "chtc";
      userEmail = "chtc@tuta.io";
    };

    yt-dlp.enable = true;
    gpg.homedir = "${config.xdg.dataHome}/gnupg";
    bash.historyFile = "${config.xdg.stateHome}/bash/history";
  };
}
