{ config, ... }:
{
  imports = [ ./associations.nix ];

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
      music = "${config.home.homeDirectory}/Media/Music";
      pictures = "${config.home.homeDirectory}/Media/Pictures";
      publicShare = "${config.home.homeDirectory}/Public/Share";
      templates = "${config.home.homeDirectory}/Public/Templates";
      videos = "${config.home.homeDirectory}/Media/Videos";
    };

    configFile = {
      "wgetrc" = {
        enable = true;
        text = ''
          hsts-file="${config.xdg.cacheHome}/wget-hsts"
        '';
      };
    };
  };

  home = {
    sessionVariables = {
      _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=${config.xdg.configHome}/java";
      ANDROID_HOME = "${config.xdg.dataHome}/android";
      ANDROID_USER_HOME = "${config.xdg.dataHome}/android";
      CUDA_CACHE_PATH = "${config.xdg.cacheHome}/nv";
      DVDCSS_CACHE = "${config.xdg.dataHome}/dvdcss";
      GNUPGHOME = "${config.xdg.dataHome}/gnupg";
      GTK2_RC_FILES = "${config.xdg.configHome}/gtk-2.0/gtkrc";
      INPUTRC = "${config.xdg.configHome}/readline/inputrc";
      LESSHISTFILE = "${config.xdg.dataHome}/lesshst";
      PULSECOOKIE = "${config.xdg.configHome}/pulse/cookie";
      WGETRC = "${config.xdg.configHome}/wgetrc";
      WINEPREFIX = "${config.xdg.dataHome}/wine";
    };
  };

  xresources.path = "${config.xdg.configHome}/X11/Xresources";
}
