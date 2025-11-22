{ config, ... }:
let
  inherit (config.home) homeDirectory;
  inherit (config.xdg) cacheHome configHome dataHome;
in
{
  imports = [ ./associations.nix ];

  xdg = {
    enable = true;
    cacheHome = "${homeDirectory}/.cache";
    configHome = "${homeDirectory}/.config";
    dataHome = "${homeDirectory}/.local/share";
    stateHome = "${homeDirectory}/.local/state";
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "${homeDirectory}/Desktop";
      documents = "${homeDirectory}/Documents";
      download = "${homeDirectory}/Downloads";
      music = "${homeDirectory}/Media/Music";
      pictures = "${homeDirectory}/Media/Pictures";
      publicShare = "${homeDirectory}/Public/Share";
      templates = "${homeDirectory}/Public/Templates";
      videos = "${homeDirectory}/Media/Videos";
    };

    configFile = {
      "wgetrc" = {
        enable = true;
        text = ''
          hsts-file="${cacheHome}/wget-hsts"
        '';
      };
    };
  };

  xresources.path = "${configHome}/X11/Xresources";
  home = {
    sessionVariables = rec {
      __GL_SHADER_DISK_CACHE_PATH = "${cacheHome}/nv";
      _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=${configHome}/java";
      ANDROID_HOME = "${dataHome}/android";
      ANDROID_USER_HOME = ANDROID_HOME;
      CUDA_CACHE_PATH = __GL_SHADER_DISK_CACHE_PATH;
      DVDCSS_CACHE = "${dataHome}/dvdcss";
      GNUPGHOME = "${dataHome}/gnupg";
      GTK2_RC_FILES = "${configHome}/gtk-2.0/gtkrc";
      INPUTRC = "${configHome}/readline/inputrc";
      LESSHISTFILE = "${dataHome}/lesshst";
      PULSECOOKIE = "${configHome}/pulse/cookie";
      WGETRC = "${configHome}/wgetrc";
      WINEPREFIX = "${dataHome}/wine";
    };
  };
}
