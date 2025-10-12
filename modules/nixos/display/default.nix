{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./cosmic.nix
    ./fonts.nix
    ./gnome.nix
  ];

  config = lib.mkIf config.mama.profiles.graphical.enable {
    boot.plymouth = {
      enable = true;
      font = "${pkgs.sarasa-gothic}/share/fonts/truetype/Sarasa-Regular.ttc";
    };

    environment.sessionVariables = {
      _JAVA_AWT_WM_NONREPARENTING = "1";
      CLUTTER_BACKEND = "wayland";
      GDK_BACKEND = "wayland";
      MOZ_ENABLE_WAYLAND = "1";
      NIXOS_OZONE_WL = "1";
      QT_QPA_PLATFORM = "wayland";
      SDL_VIDEODRIVER = "wayland";
    };

    services = {
      gvfs.enable = true;
      udisks2.enable = true;
      dbus.implementation = "broker";
      xserver.xkb = {
        layout = config.console.keyMap;
        options = "caps:swapescape";
      };
    };

    i18n.inputMethod.fcitx5.waylandFrontend = true;
  };
}
