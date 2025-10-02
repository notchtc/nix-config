{ config, lib, ... }:
{
  imports = [
    ./cosmic.nix
    ./fonts.nix
    ./gnome.nix
    ./stylix.nix
  ];

  config = lib.mkIf config.mama.profiles.graphical.enable {
    boot.plymouth.enable = true;
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
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
