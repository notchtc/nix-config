{ config, lib, ... }:
{
  imports = [
    ./environment.nix
    ./cosmic.nix
    ./fonts.nix
    ./gnome.nix
    ./stylix.nix
  ];

  config = lib.mkIf config.mama.profiles.graphical.enable {
    boot.plymouth.enable = true;
    services = {
      gvfs.enable = true;
      udisks2.enable = true;
      dbus.implementation = "broker";
      xserver = {
        autoRepeatDelay = 480;
        autoRepeatInterval = 40;
        xkb = {
          layout = config.console.keyMap;
          options = "caps:swapescape";
        };
      };
    };
  };
}
