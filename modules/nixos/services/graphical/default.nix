{ config, lib, ... }:
{
  imports = [
    ./greetd.nix
    ./kmscon.nix
    ./systemd.nix
  ];

  services = lib.mkIf config.mama.profiles.graphical.enable {
    dbus.implementation = "broker";
    gvfs.enable = true;
    udisks2.enable = true;
  };
}
