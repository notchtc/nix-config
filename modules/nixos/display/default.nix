{ config, lib, ... }:
{
  imports = [
    ./fonts.nix
    ./plasma.nix
    ./variables.nix
  ];

  config = lib.mkIf config.mama.profiles.graphical.enable {
    boot.plymouth.enable = true;
    programs.dconf.enable = true;
    i18n.inputMethod.fcitx5.waylandFrontend = true;

    services = {
      dbus.implementation = "broker";
      xserver.xkb = {
        layout = config.console.keyMap;
        options = "caps:swapescape";
      };
    };
  };
}
