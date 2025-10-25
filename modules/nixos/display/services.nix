{ config, lib, ... }:
{
  services = lib.mkIf config.mama.profiles.graphical.enable {
    gvfs.enable = true;
    udisks2.enable = true;
    dbus.implementation = "broker";
    xserver.xkb = {
      layout = config.console.keyMap;
      options = "caps:swapescape";
    };
  };
}
