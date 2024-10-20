{ config, ... }:
{
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
    file.".zshenv".enable = false;
    file.".gtkrc-2.0".enable = false;

    sessionVariables = {
      _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=${config.xdg.configHome}/java";
      LESSHISTFILE = "${config.xdg.dataHome}/lesshst";
      WGETRC = "${config.xdg.configHome}/wgetrc";
      WINEPREFIX = "${config.xdg.dataHome}/wine";
    };
  };

  programs = {
    gpg.homedir = "${config.xdg.dataHome}/gnupg";
    zsh = {
      dotDir = ".config/zsh";
      history.path = "${config.xdg.stateHome}/zsh/history";
    };
  };

  gtk.gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  xresources.path = "${config.xdg.configHome}/X11/Xresources";
}
