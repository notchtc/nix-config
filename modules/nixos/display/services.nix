{ config, lib, ... }:
let
  inherit (lib) mkIf;
  graphical = config.mama.profiles.graphical.enable;
in
{
  services = mkIf graphical {
    gvfs.enable = true;
    udisks2.enable = true;
    dbus.implementation = "broker";
    xserver.xkb = {
      layout = config.console.keyMap;
      options = "caps:swapescape";
    };
  };
}
