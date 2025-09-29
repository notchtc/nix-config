{ config, lib, ... }:
{
  config = lib.mkIf config.mama.profiles.graphical.enable {
    environment.sessionVariables = {
      _JAVA_AWT_WM_NONREPARENTING = "1";
      NIXOS_OZONE_WL = "1";
      GDK_BACKEND = "wayland,x11";
      QT_QPA_PLATFORM = "wayland";
      SDL_VIDEODRIVER = "wayland";
    };
  };
}
