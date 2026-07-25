{
  config.modules = {
    nixos.xdg = {
      xdg = {
        terminal-exec.enable = true;
        portal.xdgOpenUsePortal = true;
      };

      environment.etc."pulse/client.conf".text = ''
        autospawn=no
        cookie-file = ~/.config/pulse/cookie
      '';
    };

    home.xdg = { config, ... }: {
      environment.sessionVariables = {
        _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=${config.xdg.config.directory}/java -Djavafx.cachedir=${config.xdg.cache.directory}/openjfx";
        ANDROID_HOME = "${config.xdg.data.directory}/android";
        ANDROID_USER_HOME = "${config.xdg.data.directory}/android";
        CARGO_HOME = "${config.xdg.data.directory}/cargo";
        CUDA_CACHE_PATH = "${config.xdg.cache.directory}/nv";
        DVDCSS_CACHE = "${config.xdg.data.directory}/dvdcss";
        GNUPGHOME = "${config.xdg.data.directory}/gnupg";
        GTK2_RC_FILES = "${config.xdg.config.directory}/gtk-2.0/gtkrc";
        LESSHISTFILE = "${config.xdg.data.directory}/lesshst";
        PULSE_COOKIE = "${config.xdg.config.directory}/pulse/cookie";
        WGETRC = "${config.xdg.config.directory}/wgetrc";
        WINEPREFIX = "${config.xdg.data.directory}/wine";
      };

      xdg.config.files.wgetrc.text = ''
        hsts-file="${config.xdg.cache.directory}/wget-hsts"
      '';
    };
  };
}
