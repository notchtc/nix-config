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
      setSessionVariables = true;

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

  home = {
    preferXdgDirectories = true;
    sessionVariables = rec {
      __GL_SHADER_DISK_CACHE_PATH = "${cacheHome}/nv";
      _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=${configHome}/java";
      ANDROID_HOME = "${dataHome}/android";
      ANDROID_USER_HOME = ANDROID_HOME;
      CUDA_CACHE_PATH = __GL_SHADER_DISK_CACHE_PATH;
      DVDCSS_CACHE = "${dataHome}/dvdcss";
      GNUPGHOME = "${dataHome}/gnupg";
      LESSHISTFILE = "${dataHome}/lesshst";
      PULSE_COOKIE = "${configHome}/pulse/cookie";
      WGETRC = "${configHome}/wgetrc";
      WINEPREFIX = "${dataHome}/wine";
    };
    file = {
      ".gtkrc-2.0".enable = false;
      ".icons/default/index.theme".enable = false;
      ".icons/${config.home.pointerCursor.name}".enable = false;
    };
  };

  systemd.user.tmpfiles.rules = [
    "R ${config.home.homeDirectory}/.pki - - - - -"
    "d ${config.xdg.configHome}/pki/nssdb 0700 ${config.home.username} users -"
  ];
}
