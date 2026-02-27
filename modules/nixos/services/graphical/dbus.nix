{ config, lib, ... }:
{
  services.dbus = lib.mkIf config.mama.profiles.graphical.enable {
    enable = true;
    implementation = "broker";
  };
}
