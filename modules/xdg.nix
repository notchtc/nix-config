{
  config.modules = {
    nixos.xdg = { modules, ... }: {
      xdg = {
        terminal-exec.enable = true;
        portal.xdgOpenUsePortal = true;
      };

      hjem.extraModules = [ modules.home.xdg ];
    };

    home.xdg = { config, ... }: {
      environment.sessionVariables = {
        _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=${config.xdg.config.directory}/java";
        ANDROID_HOME = "${config.xdg.data.directory}/android";
        ANDROID_USER_HOME = "${config.xdg.data.directory}/android";
        CARGO_HOME = "${config.xdg.data.directory}/cargo";
        CUDA_CACHE_PATH = "${config.xdg.cache.directory}/nv";
        DVDCSS_CACHE = "${config.xdg.data.directory}/dvdcss";
        GNUPGHOME = "${config.xdg.data.directory}/gnupg";
        LESSHISTFILE = "${config.xdg.data.directory}/lesshst";
        PULSE_COOKIE = "${config.xdg.config.directory}/pulse/cookie";
        WGETRC = "${config.xdg.config.directory}/wgetrc";
        WINEPREFIX = "${config.xdg.data.directory}/wine";
      };

      xdg.config.files = {
        wgetrc.text = ''
          hsts-file="${config.xdg.cache.directory}/wget-hsts"
        '';

        "user-dirs.dirs".text = ''
          XDG_DESKTOP_DIR="${config.directory}/Desktop"
          XDG_DOCUMENTS_DIR="${config.directory}/Documents"
          XDG_DOWNLOAD_DIR="${config.directory}/Downloads"
          XDG_MUSIC_DIR="${config.directory}/Music"
          XDG_PICTURES_DIR="${config.directory}/Pictures"
          XDG_PROJECTS_DIR="${config.directory}/Projects"
          XDG_PUBLICSHARE_DIR="${config.directory}/Public/Share"
          XDG_TEMPLATES_DIR="${config.directory}/Public/Templates"
          XDG_VIDEOS_DIR="${config.directory}/Videos"
        '';
      };
    };
  };
}
