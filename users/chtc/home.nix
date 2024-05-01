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
        easyeffects
        gimp
        keepassxc
        lutris
        picard
        qbittorrent
        strawberry-qt6
        telegram-desktop
        vesktop
        ;
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
    stateVersion = lib.mkDefault "23.11";
  };

  xdg = {
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
