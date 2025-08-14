{ config, ... }:
{
  nix.settings.use-xdg-base-directories = true;
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
    file = {
      ".zshenv".enable = false;
      ".gtkrc-2.0".enable = false;
      ".icons/default/index.theme".enable = false;
      ".icons/${config.home.pointerCursor.name}".enable = false;
    };

    sessionVariables = {
      _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=${config.xdg.configHome}/java";
      ANDROID_USER_HOME = "${config.xdg.dataHome}/android";
      DVDCSS_CACHE = "${config.xdg.dataHome}/dvdcss";
      GNUPGHOME = "${config.xdg.dataHome}/gnupg";
      LESSHISTFILE = "${config.xdg.dataHome}/lesshst";
      PULSECOOKIE = "${config.xdg.configHome}/pulse/cookie";
      WGETRC = "${config.xdg.configHome}/wgetrc";
      WINEPREFIX = "${config.xdg.dataHome}/wine";
    };
  };

  programs = {
    zsh = {
      dotDir = "${config.xdg.configHome}/zsh";
      history.path = "${config.xdg.stateHome}/zsh/history";
    };
  };

  gtk.gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  xresources.path = "${config.xdg.configHome}/X11/Xresources";
}
